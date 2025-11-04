package egovframework.let.cmm.support;

import java.util.Iterator;

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
public final class KeyValuePairParser {
	private String str;

	private int idx;

	private String key;

	private String value;

	private final StringBuilder buf = new StringBuilder();

	public KeyValuePairParser() {
	}

	public KeyValuePairParser(String s) {
		set(s);
	}

	public void set(String str) {
		this.str = str;
		this.idx = 0;
	}

	public boolean hasNext() {
		return (this.idx < this.str.length());
	}

	private int indexOf(char separator) {
		int i = this.str.indexOf(separator, this.idx + 1);
		if (i < 0)
			return this.str.length();
		return i;
	}

	private boolean isAt(char ch) {
		return (this.idx < this.str.length() && this.str.charAt(this.idx) == ch);
	}

	private char current() {
		return this.str.charAt(this.idx);
	}

	public void parseNext() {
		int del = Math.min(indexOf('='), indexOf(','));
		this.key = this.str.substring(this.idx, del);
		this.value = null;
		this.idx = del;
		if (this.idx == this.str.length())
			return;
		if (current() == ',') {
			this.idx++;
			return;
		}
		assert current() == '=';
		this.idx++;
		if (isAt('\'') || isAt('"')) {
			char quote = current();
			this.idx++;
			this.buf.setLength(0);
			while (true) {
				if (isAt(quote)) {
					this.value = this.buf.toString();
					this.idx += 2;
					return;
				}
				if (isAt('\\'))
					this.idx++;
				this.buf.append(current());
				this.idx++;
			}
		}
		int end = indexOf(',');
		this.value = this.str.substring(this.idx, end);
		this.idx = end + 1;
	}

	public String getKey() {
		return this.key;
	}

	public String getValue() {
		return this.value;
	}

	public void rewind() {
		this.idx = 0;
	}

	public String find(String key) {
		while (hasNext()) {
			parseNext();
			if (getKey().equals(key))
				return getValue();
		}
		return null;
	}

	/*
	public Iterable<String> findAll(final String key) {
	    return new Iterable<String>() {
	        public Iterator<String> iterator() {
	          KeyValuePairParser.this.rewind();
	          return new Iterator<String>() {
	              private String next;
	              
	              private void fetch() {
	                if (this.next == null)
	                  this.next = KeyValuePairParser.null.access$0(KeyValuePairParser.null.this).find(key); 
	              }
	              
	              public boolean hasNext() {
	                fetch();
	                return (this.next != null);
	              }
	              
	              public String next() {
	                fetch();
	                String r = this.next;
	                this.next = null;
	                return r;
	              }
	              
	              public void remove() {
	                throw new UnsupportedOperationException();
	              }
	            };
	        }
	      };
	  }
	  */

	public String getLine() {
		return this.str;
	}
}