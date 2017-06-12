var AccountValidate = function () {

	var handleLogin = function() {
		$('.login-form').validate({
			errorElement: 'span', //default input error message container
			errorClass: 'help-block', // default input error message class
			focusInvalid: false, // do not focus the last invalid input
			rules: {
				userAccount: {
					required: true
				},
				userPassword: {
					required: true
				},
				communityPassword: {
					required: true
				}
			},

			messages: {
				userAccount: {
					required: "用户名不能为空"
				},
				userPassword: {
					required: "密码不能为空"
				}
//				communityPassword: {
//					required: "社区密码不能为空"
//				}
			},

			invalidHandler: function (event, validator) { //display error alert on form submit   
				$('.alert-error', $('.login-form')).show();
			},

			highlight: function (element) { // 给未通过验证的元素加效果
				$(element)
					.closest('.form-group').addClass('has-error'); // set error class to the control group
			},

			success: function (label) {
				label.closest('.form-group').removeClass('has-error');
				label.remove();
			},

			errorPlacement: function (error, element) {
				error.insertAfter(element.closest('.input-icon'));
			},
			showErrors:function(errorMap,errorList) {
		        if(this.numberOfInvalids()>0){
		        	$('.field-has-error').html("");
		        }
				this.defaultShowErrors();
			},
			submitHandler: function (form) {  //通过验证后运行的函数
				form.submit();
			}
		});

		$('.login-form input').keypress(function (e) {
			if (e.which == 13) {
				if ($('.login-form').validate().form()) {
					$('.login-form').submit();
				}
				return false;
			}
		});
	};
    
    return {
        //main function to initiate the module
        handleLogin: function () {	
            handleLogin();   
        }
    };

}();

jQuery.validator.addMethod("account", function(value, element) {   
    var tel = /^[a-zA-Z_][a-zA-Z0-9_]*$/;
    return this.optional(element) || (tel.test(value));
}, "开头必须为字母、数字或下划线，不能以数字开头");

/*jQuery.validator.addMethod("password", function(value, element) {   
    var tel = /^((?=.*?\d)(?=.*?[A-Za-z])|(?=.*?\d)(?=.*?[!@#$%^&])|(?=.*?[A-Za-z])(?=.*?[!@#$%^&]))[\dA-Za-z!@#$%^&]+$/;
    return this.optional(element) || (tel.test(value));
}, "密码必须包含字母、数字、符号中的至少2种");*/

jQuery.validator.addMethod("phone", function(value, element) {   
    var tel = /^1[3-8]\d{9}$/;
    return this.optional(element) || (tel.test(value));
}, "请输入正确的手机号码");