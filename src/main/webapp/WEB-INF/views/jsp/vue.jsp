<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
</head>
<body>
<!--객체 바인딩-->
	<div class="static" v-bind:class="{ active: isActive, 'text-danger': hasError }">
		Hello
	</div>
	
	<div id="example">
		<p>{{message}}</p>
		<p>{{revmessage}}</p>	
	</div>
	
	<div id = "demo">
		{{fullName}}
	</div>
	
	<div id = "demo2">
		{{fullName}}
	</div>
	
	<div id="watch-example">
  	<p>
    yes/no 질문을 물어보세요:
    <input v-model="question">
  	</p>
  	<p>{{ answer }}</p>
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
});

//computed 객체를 다시 사용 할 수있음 대상을 종속시켜 message가 변하지 않는 이상 같은 값을 출력
var exam = new Vue({
	el : "#example",
	data : {
		message : "Hello"
	},
	computed : {
		revmessage: function() {
			return this.message.split('').reverse().join('')
		}
	}
});
//watch?
var demo = new Vue ({
	el : "#demo",
	data : {
		firstName : "KiBongs",
		lastName : "Kims", 
		fullName : "Kim KiBong"		
	},
	watch : {
		firstname : function (val){
			this.fullName = val + '' + this.lastName
		},
		lastName : function (val){
			this.fullName = this.fristName + '' + val
		}
	}
	
	
});
//동적으로 변경
var demo2 = new Vue ({
	el : "#demo2",
	data : {
		firstName : "KiBong",
		lastName : "Kim", 
	},
	computed : {
		fullName :{
			
		get : function() {
			return this.firstName + this.lastName
		},
		set : function (newValue) {
			var names = newValue.split(' ')			
		    this.firstName = names[0];
		    this.lastName = names[names.length - 1]
			}
		}
	
	}
});

var watchExampleVM = new Vue({
	  el: '#watch-example',
	  data: {
	    question: '',
	    answer: '질문을 하기 전까지는 대답할 수 없습니다.'
	  },
	  watch: {
	    // 질문이 변경될 때 마다 이 기능이 실행됩니다.
	    question: function (newQuestion) {
	      this.answer = '입력을 기다리는 중...';
	      this.getAnswer()
	    }
	  },
	  methods: {
	    // _.debounce는 lodash가 제공하는 기능으로
	    // 특히 시간이 많이 소요되는 작업을 실행할 수 있는 빈도를 제한합니다.
	    // 이 경우, 우리는 yesno.wtf/api 에 액세스 하는 빈도를 제한하고,
	    // 사용자가 ajax요청을 하기 전에 타이핑을 완전히 마칠 때까지 기다리길 바랍니다.
	    // _.debounce 함수(또는 이와 유사한 _.throttle)에 대한
	    // 자세한 내용을 보려면 https://lodash.com/docs#debounce 를 방문하세요.
	    getAnswer: _.debounce(
	      function () {
	        if (this.question.indexOf('?') === -1) {
	        console.log(this.question);
	          this.answer = '질문에는 일반적으로 물음표가 포함 됩니다. ;-)'
	          return
	        }
	        this.answer = '생각중...'
	        var vm = this
	        axios.get('https://yesno.wtf/api')
	          .then(function (response) {
	            vm.answer = _.capitalize(response.data.answer)
	          })
	          .catch(function (error) {
	            vm.answer = '에러! API 요청에 오류가 있습니다. ' + error;
	          })
	      },
	      // 사용자가 입력을 기다리는 시간(밀리세컨드) 입니다.
	      500
	    )
	  }
	});

demo2.fullName = 'Bong Bong'
</script>
</html>