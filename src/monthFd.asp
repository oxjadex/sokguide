<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>이달의음식</title>
<script type='text/javascript'>

//조회
function mainMove(){
	with(document.searchYearForm){
		method="post";
		action = "monthFd.asp";
		target = "_self";
		submit();
	}
}
//식재료 상세보기
function move1(dNo){
	with(document.searchYearForm){
		cntntsNo.value = dNo;
		method="get";
		action = "monthFd_D1.asp";
		target = "_self";
		submit();
	}
}
//레시피 상세보기
function move2(dNo){
	with(document.searchYearForm){
		cntntsNo.value = dNo;
		method="get"; 
		action = "monthFd_D2.asp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>이달의음식</strong></h3>
<hr>

<%
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	apiKey="40dc7b48ad418f2d49063f0fda9c574054406f5e99b06a59b4f95b0470524c6e"

	'서비스 명
	serviceName="monthFd"

	'선택년도
	thisYear = ""
	If Not Request("thisYear") Is Nothing And Request("thisYear") <> "" Then
		thisYear=Request("thisYear")
	Else
		thisYear=Left(Date(),4)
	End If

	'선택월
	thisMonth = ""
	If Not Request("thisMonth") Is Nothing And Request("thisMonth") <> "" Then
		thisMonth=Request("thisMonth")
	Else
		thisMonth=Mid(Date(),6,2)
	End If

	'기관 코드
	'오퍼레이션 명
	operationName="monthFdYearLst"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey

	targetURL = "http://api.nongsaro.go.kr/service" & parameter

	'농사로 Open API 통신 시작
	Set xmlHttp1 = Server.CreateObject("Microsoft.XMLHTTP")
	xmlHttp1.Open "GET", targetURL, False
	xmlHttp1.Send

	Set oStream1 = CreateObject("ADODB.Stream")
	oStream1.Open
	oStream1.Position = 0
	oStream1.Type = 1
	oStream1.Write xmlHttp1.ResponseBody
	oStream1.Position = 0
	oStream1.Type = 2
	oStream1.Charset = "utf-8"
	sText = oStream1.ReadText
	oStream1.Close

	Set xmlDOM1 = server.CreateObject("MSXML.DOMDOCUMENT")
	xmlDOM1.async = False
	xmlDOM1.LoadXML sText
	'농사 Open API 통신 끝

	Set listItem1 = xmlDOM1.SelectNodes("//items")
	cnt = listItem1(0).childNodes.length
	Set items1 = listItem1(0).childNodes

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<form name="searchYearForm">
	<input type="hidden" name="cntntsNo"/>
		연도&nbsp;
		<select name="thisYear" onchange="mainMove();">
<%
		For i=0 To cnt-1
		   Set itemNode = items1.item(i)
			If NOT itemNode Is Nothing Then
				'연도
				If NOT itemNode.SelectSingleNode("year") is Nothing Then
					codeNm = itemNode.SelectSingleNode("year").text
				End If
			End If
%>
			<option value="<%=codeNm%>" <%If codeNm = thisYear Then Response.Write("selected") Else Response.Write("") End If%>><%=codeNm%></option>
<%
		   Set itemNode = Nothing
		Next
	Response.Write("</select></form>")
%>

		월&nbsp;
		<select name="thisMonth" onchange="mainMove();">
			<option value="01" <%If thisMonth = "01" Then Response.Write("selected") Else Response.Write("") End If%>>1월</option>
			<option value="02" <%If thisMonth = "02" Then Response.Write("selected") Else Response.Write("") End If%>>2월</option>
			<option value="03" <%If thisMonth = "03" Then Response.Write("selected") Else Response.Write("") End If%>>3월</option>
			<option value="04" <%If thisMonth = "04" Then Response.Write("selected") Else Response.Write("") End If%>>4월</option>
			<option value="05" <%If thisMonth = "05" Then Response.Write("selected") Else Response.Write("") End If%>>5월</option>
			<option value="06" <%If thisMonth = "06" Then Response.Write("selected") Else Response.Write("") End If%>>6월</option>
			<option value="07" <%If thisMonth = "07" Then Response.Write("selected") Else Response.Write("") End If%>>7월</option>
			<option value="08" <%If thisMonth = "08" Then Response.Write("selected") Else Response.Write("") End If%>>8월</option>
			<option value="09" <%If thisMonth = "09" Then Response.Write("selected") Else Response.Write("") End If%>>9월</option>
			<option value="10" <%If thisMonth = "10" Then Response.Write("selected") Else Response.Write("") End If%>>10월</option>
			<option value="11" <%If thisMonth = "11" Then Response.Write("selected") Else Response.Write("") End If%>>11월</option>
			<option value="12" <%If thisMonth = "12" Then Response.Write("selected") Else Response.Write("") End If%>>12월</option>
		</select>
	</form>
<%
	End If
%>
<!-- =================================================== 메인 카테고리 시작 ================================================================================ -->

<%
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "monthFd"
	'오퍼레이션 명
	operationName = "monthFdmtLst"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&thisYear=" & thisYear
	parameter = parameter & "&thisMonth=" & thisMonth

	targetURL = "http://api.nongsaro.go.kr/service" & parameter

	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
	xmlHttp.Open "GET", targetURL, False
	xmlHttp.Send

	Set oStream = CreateObject("ADODB.Stream")
	oStream.Open
	oStream.Position = 0
	oStream.Type = 1
	oStream.Write xmlHttp.ResponseBody
	oStream.Position = 0
	oStream.Type = 2
	oStream.Charset = "utf-8"
	sText = oStream.ReadText
	oStream.Close

	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")
	xmlDOM.async = False
	xmlDOM.LoadXML sText
	'농사 Open API 통신 끝

	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<div>
	<ul>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'키값
				If NOT itemNode.SelectSingleNode("cntntsNo") is Nothing Then
					cntntsNo = itemNode.SelectSingleNode("cntntsNo").text
				End If
				'파일구분코드
				If NOT itemNode.SelectSingleNode("rtnImgSeCode") is Nothing Then
					rtnImgSeCode = itemNode.SelectSingleNode("rtnImgSeCode").text
				End If
				'파일경로
				If NOT itemNode.SelectSingleNode("rtnFileCours") is Nothing Then
					rtnFileCours = itemNode.SelectSingleNode("rtnFileCours").text
				End If
				'파일명
				If NOT itemNode.SelectSingleNode("rtnStreFileNm") is Nothing Then
					rtnStreFileNm = itemNode.SelectSingleNode("rtnStreFileNm").text
				End If
				'파일제목
				If NOT itemNode.SelectSingleNode("fdmtNm") is Nothing Then
					fdmtNm = itemNode.SelectSingleNode("fdmtNm").text
				End If
			End If

		imgCnt = -1
		rtnImgSeCodeArr= split(rtnImgSeCode,"|")
		for k=0 to UBound(rtnImgSeCodeArr)
			If rtnImgSeCodeArr(k) = "209006"  Then
				imgCnt = k
			End If
		next

		imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg"

		If imgCnt > -1 Then
			rtnFileCoursArr = split(rtnFileCours,"|")
			rtnStreFileNmArr = split(rtnStreFileNm,"|")
			imgUrl = "http://www.nongsaro.go.kr/" & rtnFileCoursArr(imgCnt) & "/" & rtnStreFileNmArr(imgCnt)
		End If

%>

		<li style="width: 33%;display: inline-block;"><a href="#" onclick="javascript:;move1('<%=cntntsNo%>');">
		<img src="<%=imgUrl%>" alt="<%=fdmtNm%>"  title="<%=fdmtNm%>" style="width: 249px;height: 198px;"/>
		</a>
		<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><%=fdmtNm%></p>
		</li>

<%
		   Set itemNode = Nothing
		Next
		Response.Write("</ul></div>")
	End If

	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "monthFd"
	'오퍼레이션 명
	operationName = "monthNewFdLst"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&thisYear=" & thisYear
	parameter = parameter & "&thisMonth=" & thisMonth

	targetURL = "http://api.nongsaro.go.kr/service" & parameter

	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
	xmlHttp.Open "GET", targetURL, False
	xmlHttp.Send

	Set oStream = CreateObject("ADODB.Stream")
	oStream.Open
	oStream.Position = 0
	oStream.Type = 1
	oStream.Write xmlHttp.ResponseBody
	oStream.Position = 0
	oStream.Type = 2
	oStream.Charset = "utf-8"
	sText = oStream.ReadText
	oStream.Close

	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")
	xmlDOM.async = False
	xmlDOM.LoadXML sText
	'농사 Open API 통신 끝

	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<div>
	<ul>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'키값
				If NOT itemNode.SelectSingleNode("cntntsNo") is Nothing Then
					cntntsNo = itemNode.SelectSingleNode("cntntsNo").text
				End If
				'파일구분코드
				If NOT itemNode.SelectSingleNode("rtnImgSeCode") is Nothing Then
					rtnImgSeCode = itemNode.SelectSingleNode("rtnImgSeCode").text
				End If
				'파일경로
				If NOT itemNode.SelectSingleNode("rtnFileCours") is Nothing Then
					rtnFileCours = itemNode.SelectSingleNode("rtnFileCours").text
				End If
				'파일명
				If NOT itemNode.SelectSingleNode("rtnStreFileNm") is Nothing Then
					rtnStreFileNm = itemNode.SelectSingleNode("rtnStreFileNm").text
				End If
				'파일제목
				If NOT itemNode.SelectSingleNode("fdNm") is Nothing Then
					fdNm = itemNode.SelectSingleNode("fdNm").text
				End If
				'레시피구분
				If NOT itemNode.SelectSingleNode("fdSeCode") is Nothing Then
					fdSeCode = itemNode.SelectSingleNode("fdSeCode").text
				End If
			End If


			If fdSeCode = "290001"  Then
				imgCnt = -1
				rtnImgSeCodeArr= split(rtnImgSeCode,"|")
				for k=0 to UBound(rtnImgSeCodeArr)
					If rtnImgSeCodeArr(k) = "209006"  Then
						imgCnt = k
					End If
				next

				imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg"

				If imgCnt > -1 Then
					rtnFileCoursArr = split(rtnFileCours,"|")
					rtnStreFileNmArr = split(rtnStreFileNm,"|")
					imgUrl = "http://www.nongsaro.go.kr/" & rtnFileCoursArr(imgCnt) & "/" & rtnStreFileNmArr(imgCnt)
				End If

%>
				<li>
					<li style="width: 33%;display: inline-block;"><a href="#" onclick="javascript:;move2('<%=cntntsNo%>');">
					<img src="<%=imgUrl%>" alt="<%=fdNm%>"  title="<%=fdNm%>" style="width: 249px;height: 198px;"/>
					</a>
					<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><%=fdNm%></p>
					</li>
				</li>
<%
			End If
		   Set itemNode = Nothing
		Next
		Response.Write("</ul></div>")
	End If

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<div>
	<ul>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'키값
				If NOT itemNode.SelectSingleNode("cntntsNo") is Nothing Then
					cntntsNo = itemNode.SelectSingleNode("cntntsNo").text
				End If
				'파일구분코드
				If NOT itemNode.SelectSingleNode("rtnImgSeCode") is Nothing Then
					rtnImgSeCode = itemNode.SelectSingleNode("rtnImgSeCode").text
				End If
				'파일경로
				If NOT itemNode.SelectSingleNode("rtnFileCours") is Nothing Then
					rtnFileCours = itemNode.SelectSingleNode("rtnFileCours").text
				End If
				'파일명
				If NOT itemNode.SelectSingleNode("rtnStreFileNm") is Nothing Then
					rtnStreFileNm = itemNode.SelectSingleNode("rtnStreFileNm").text
				End If
				'파일제목
				If NOT itemNode.SelectSingleNode("fdNm") is Nothing Then
					fdNm = itemNode.SelectSingleNode("fdNm").text
				End If
				'레시피구분
				If NOT itemNode.SelectSingleNode("fdSeCode") is Nothing Then
					fdSeCode = itemNode.SelectSingleNode("fdSeCode").text
				End If
			End If


			If fdSeCode = "290002" OR fdSeCode = "290003" Then
				imgCnt = -1
				rtnImgSeCodeArr= split(rtnImgSeCode,"|")
				for k=0 to UBound(rtnImgSeCodeArr)
					If rtnImgSeCodeArr(k) = "209006"  Then
						imgCnt = k
					End If
				next

				imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg"

				If imgCnt > -1 Then
					rtnFileCoursArr = split(rtnFileCours,"|")
					rtnStreFileNmArr = split(rtnStreFileNm,"|")
					imgUrl = "http://www.nongsaro.go.kr/" & rtnFileCoursArr(imgCnt) & "/" & rtnStreFileNmArr(imgCnt)
				End If

%>
				<li>
					<li style="width: 33%;display: inline-block;"><a href="#">
					<img src="<%=imgUrl%>" alt="<%=fdNm%>"  title="<%=fdNm%>" style="width: 249px;height: 198px;"/>
					</a>
					<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><%=fdNm%></p>
					</li>
				</li>
<%
			End If
		   Set itemNode = Nothing
		Next
		Response.Write("</ul></div>")
	End If
%>
</body>
</html>