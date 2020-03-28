<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
	<div id="root">
		<div v-if="liked">좋아요 눌렀음</div>
		<button v-on:click="onClickButton">Like</button>
	</div>
</body>
<script>
var app = new Vue({
	el: '#root',
	data : {
		liked : false,
	},
	methods : {
		onClickButton(){
		this.liked = true;		
		},	
	},
	
});
</script>
</html>