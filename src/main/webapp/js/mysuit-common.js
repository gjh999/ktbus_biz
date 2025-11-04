var mysuitModule = (function() {

	function gfn_reportCall(_objFormData, _url, _iframeName) {

		for (var datasetValue in _objFormData.datasetList) {
			_objFormData[datasetValue] = encodeURIComponent(_objFormData.datasetList[datasetValue]);
		}

		for (var paramValue in _objFormData.paramList) {
			_objFormData[paramValue] = _objFormData.paramList[paramValue];
		}

		var form = document.createElement("form");

		form.setAttribute("method", "post");
		form.setAttribute("action", _url);

		for (var i in _objFormData) {
			if (_objFormData.hasOwnProperty(i)) {
				var param = document.createElement('input');
				param.type = 'hidden';
				param.name = i;
				param.value = encodeURIComponent(_objFormData[i]);
				form.appendChild(param);
			}
		}

		if (_iframeName == undefined || _iframeName == null) {
			var d = new Date();
			var n = d.getTime();
			var name = "UBF_" + n;
			var windowoption = 'location=0, directories=0,resizable=0,status=0,toolbar=0,menubar=0, width=' + screen.width + ',height=' + screen.height + ',left=0, top=0,scrollbars=0';
			form.target = name;
			window.open("", name, windowoption);
		} else {
			form.target = _iframeName;
		}

		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}

	function gfn_exportServerSide(_objFormData, _url) {

		for (var datasetValue in _objFormData.datasetList) {
			_objFormData[datasetValue] = encodeURIComponent(_objFormData.datasetList[datasetValue]);
		}

		for (var paramValue in _objFormData.paramList) {
			_objFormData[paramValue] = _objFormData.paramList[paramValue];
		}

		var form = document.createElement("form");

		form.setAttribute("method", "post");
		form.setAttribute("action", _url);

		for (var i in _objFormData) {
			if (_objFormData.hasOwnProperty(i)) {
				var param = document.createElement('input');
				param.type = 'hidden';
				param.name = i;
				param.value = encodeURIComponent(_objFormData[i]);
				form.appendChild(param);
			}
		}

		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}

	function gfn_pdf_Print(_objFormData, _url) {
		/* !! application 과 MYSUIT 의 도메인이 다른경우 UBIFORM 서버에 크로스도메인 허용 설정해야함 */

		for (var datasetValue in _objFormData.datasetList) {
			_objFormData[datasetValue] = encodeURIComponent(_objFormData.datasetList[datasetValue]);
		}

		for (var paramValue in _objFormData.paramList) {
			_objFormData[paramValue] = _objFormData.paramList[paramValue];
		}

		var form = document.createElement("form");

		form.setAttribute("method", "post");
		form.setAttribute("action", _url);

		for (var i in _objFormData) {
			if (_objFormData.hasOwnProperty(i)) {
				var param = document.createElement('input');
				param.type = 'hidden';
				param.name = i;
				param.value = encodeURIComponent(_objFormData[i]);
				form.appendChild(param);
			}
		}

		document.body.appendChild(form);
		form.setAttribute("target", "pdfIframe");
		fn_makePrintTargetFrame("pdfIframe");

		form.submit();

		document.body.removeChild(form);
	}

	function fn_makePrintTargetFrame(_targetName) {
		var iframe;

		if (document.getElementById(_targetName) == null) {
			iframe = document.createElement('iframe');
			iframe.setAttribute('name', _targetName);
			iframe.setAttribute('title', "PRINT_IFRAME");
			iframe.style.display = 'none';

			document.body.appendChild(iframe);
		} else {
			iframe = document.getElementById(_targetName);
		}

		iframe.onload = function() {
			var win = iframe.contentWindow;

			win.focus();
			win.print();
		}

		return iframe;
	}

	function gfn_LX_Print(_arrDataList, _callbackSucc, _callbackFail) {

		var arrDataList = new Array();
		var objFormData = new Object();

		for (var i = 0; i < _arrDataList.length; i++) {
			objFormData = _arrDataList[i];

			for (var datasetValue in objFormData.datasetList) {
				objFormData[datasetValue] = encodeURIComponent(objFormData.datasetList[datasetValue]);
			}

			for (var paramValue in objFormData.paramList) {
				objFormData[paramValue] = objFormData.paramList[paramValue];
			}

			arrDataList.push(objFormData);
		}

		UBLocalExporter.sendLocalPdfAll(arrDataList, _callbackSucc, _callbackFail);
	}


	function gfn_epEditorCall(_params, _url, _iframeName) {

		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", _url);

		for (var i in _params) {
			if (_params.hasOwnProperty(i)) {
				var param = document.createElement('input');
				param.type = 'hidden';
				param.name = i;
				if (i == "EP_EFORMDOC") {
					param.value = _params[i];
				} else {
					param.value = encodeURIComponent(_params[i]);
				}
				form.appendChild(param);
			}
		}

		if (_iframeName == undefined || _iframeName == null) {
			var d = new Date();
			var n = d.getTime();
			var name = "UBF_" + n;
			var windowoption = 'location=0, directories=0,resizable=0,status=0,toolbar=0,menubar=0, width=' + screen.width + ',height=' + screen.height + ',left=0, top=0,scrollbars=0';
			form.target = name;
			window.open("", name, windowoption);
		} else {
			form.target = _iframeName;
		}

		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}


	function gfn_epViewerCall(_params, _url, _iframeName) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", _url);

		for (var i in _params) {
			if (_params.hasOwnProperty(i)) {
				var param = document.createElement('input');
				param.type = 'hidden';
				param.name = i;
				if (i == "EP_EFORMDOC") {
					param.value = _params[i];
				} else {
					param.value = encodeURIComponent(_params[i]);
				}
				form.appendChild(param);
			}
		}

		if (_iframeName == undefined || _iframeName == null) {
			var d = new Date();
			var n = d.getTime();
			var name = "UBF_" + n;
			var windowoption = 'location=0, directories=0,resizable=0,status=0,toolbar=0,menubar=0, width=' + screen.width + ',height=' + screen.height + ',left=0, top=0,scrollbars=0';
			form.target = name;
			window.open("", name, windowoption);
		} else {
			form.target = _iframeName;
		}

		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}

	return {
		gfn_reportCall: gfn_reportCall,
		gfn_exportServerSide: gfn_exportServerSide,
		gfn_pdf_Print: gfn_pdf_Print,
		gfn_LX_Print: gfn_LX_Print,
		gfn_epEditorCall: gfn_epEditorCall,
		gfn_epViewerCall: gfn_epViewerCall
	};

})(window);  