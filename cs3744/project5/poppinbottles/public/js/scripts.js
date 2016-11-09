$(document).ready(function(){

	var flag = true;
	// does the change of image and the effects
	function changeImage( ImNum )
	{
		$('#vineImag').fadeOut(350, function() {
			if(flag == true) { 
				$('#buttonBar').append("<br> <br><a href='aboutUs/' <h5 id='picMes'> Check Out: AboutUs for more information on our Vineyard Locations! </h5></a>");
				$('#picMes').css('color', 'white');
				$('#picMes').css('font-style', 'italic');
				flag = false;
			}
			$('#vineImag').attr("src","/GUIProject5/cs3744/project5/poppinbottles/public/img/" + ImNum);
			$('#vineImag').fadeIn(350);
		});
		return false;
	}

		//event trigger for the login bar being empty
		//changes everything to red until both fields are filled
	$('#login .logForm').click(function(){
		var value1 = $('#login .user').val();
		var value2 = $('#login .pass').val();
		if (value1 == '' || value2 == '') {
			$('#login .inputForm').css('background-color', 'red');
			$(this).css('color', 'red');
			
			if ( !$('#warning').length ) {
				$("#login").prepend("<h1 id='warning'>Empty Field(s)!</h1>");
				$("#warning").css("color", "red");
				$("#warning").css("margin-right", "5px");
				$("#warning").css("font-size", "16pt");
			}
			return false;
		}
		else{
			$('#login .inputForm').css('background-color', 'white');
			$(this).css('color', 'white');	
			if ( $('#warning').length ) {
				$("#warning").remove();
			}
		}
	});

	$('#newsletter .submit').click(function(){
		var value1 = $('#newsletter .name').val();
		var value2 = $('#newsletter .email').val();
		if (value1 == '' || value2 == '') {
			$('#newsletter .inputForm').css('background-color', 'red');
			$(this).css('color', 'red');	
			return false;
		}
		else{
			$('#newsletter .inputForm').css('background-color', 'white');
			$(this).css('color', 'white');	
		}
	});


	//button event triggers for switching vineyard pictures.
	$('#vin1button').click(function(){
		var src=$('#vineImag').attr("src");
		if(src == "img/vin1.jpg" ) {
   			return;
		}else {
   			changeImage('vin1.jpg');
		}
		return;
	});

	$('#vin2button').click(function(){
		var src=$('#vineImag').attr("src");
		if(src == "img/vin2.jpg" ) {
   			return;
		}else {
   			changeImage('vin2.jpg');
		}
		return;
	});

	$('#vin3button').click(function(){
		var src=$('#vineImag').attr("src");
		if(src == "img/vin3.jpg" ) {
   			return;
		}else {
   			changeImage('vin3.jpg');
		}
		return;
	});

	//event trigger for the search bar being empty
	$('#createAccount .submit').click(function(){
		var firstname = document.getElementsByName("accountfirstname")[0].value;
		var lastname = document.getElementsByName("accountlastname")[0].value;
		var email = document.getElementsByName("accountemail")[0].value;
		var username = document.getElementsByName("accountusername")[0].value;
		var password = document.getElementsByName("accountpassword")[0].value;

		if (firstname == '' || lastname == '' || email == '' || username == '' || password == '') {
			$('#createAccount .inputForm').css('background-color', 'red');
			$(this).css('color', 'red');

			if ( !$('#warning2').length ) {
				$("#createAccount").prepend("<h1 id='warning2'>Empty Field(s)!</h1>");
				$("#warning2").css("color", "red");
				$("#warning2").css("margin-right", "5px");
				$("#warning2").css("font-size", "16pt");
			}
			return false;	
		}
		else{
			$('#createAccount .inputForm').css('background-color', 'white');
			$('#createAccount .inputForm').css('color', 'white');	
			$("input.gsc-input").attr("value", value);	
			if ( $('#warning2').length ) {
				$("#warning2").remove();
			}
			return true;
		}
	});

});