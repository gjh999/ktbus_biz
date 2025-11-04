package egovframework.let.cmm.util;

import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * 
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일              수정자           수정내용
 *  ----------  --------   ---------------------------
 *  2011.08.31  JJY        최초 생성
 *  2021.08.12  신용호            추가 URL 생성
 *
 *      </pre>
 */
public class RSSReader {
	private static RSSReader instance = null;

	private URL rssURL;

	public static RSSReader getInstance() {
		if (instance == null)
			instance = new RSSReader();
		return instance;
	}

	public void setURL(URL url) {
		this.rssURL = url;
	}

	public List<HashMap<String, Object>> resultFeed() {
		List<HashMap<String, Object>> rssList = new ArrayList<>();
		try {
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			Document doc = builder.parse(this.rssURL.openStream());
			NodeList items = doc.getElementsByTagName("item");
			for (int ii = 0; ii < items.getLength(); ii++) {
				Element item = (Element) items.item(ii);
				HashMap<String, Object> rss = new HashMap<>();
				rss.put("title", StringUtil.nvl(getValue(item, "title")));
				rss.put("description",
						StringUtil.nvl(getValue(item, "description")).replace("&nbsp;&nbsp;&nbsp;&nbsp; ", ""));
				rss.put("link", StringUtil.nvl(getValue(item, "link")));
				rss.put("author", StringUtil.nvl(getValue(item, "author")));
				rss.put("pubDate", StringUtil.nvl(getValue(item, "pubDate")));
				rssList.add(rss);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rssList;
	}

	public String getValue(Element parent, String nodeName) {
		return parent.getElementsByTagName(nodeName).item(0).getFirstChild().getNodeValue();
	}

	public static void main(String[] args) {
		try {
			RSSReader reader = getInstance();
			reader.setURL(new URL("http://www.gyotongn.com/rss/allArticle.xml"));
			reader.resultFeed();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}