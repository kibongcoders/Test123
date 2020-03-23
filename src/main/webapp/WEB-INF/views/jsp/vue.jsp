<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
<!--객체 바인딩-->
	<div class="static" v-bind:class="{ active: isActive, 'text-danger': hasError }">
		Hello
	</div>
</body>
<script type="text/javascript">
// 객체 바인딩
var app = new Vue({
	el : ".static",
	data : {
	 isActive: true,
	 hasError: true
	}
})
</script>
</html>