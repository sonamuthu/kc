<%--
 Copyright 2005-2014 The Kuali Foundation
 
 Licensed under the Educational Community License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.osedu.org/licenses/ECL-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
--%>
<%@ include file="/kr/WEB-INF/jsp/tldHeader.jsp"%>
<%@ include file="/WEB-INF/jsp/kraTldHeader.jsp"%>


<html>
		<input type="hidden" name="personIndex" value="${personIndex}" />
		<table class=tab cellpadding=0 cellspacing="0" summary="">
			<tr>

				<td><c:out value="${comments}" /></td>
			</tr>

		</table>
</html>