<div id="newUserContent">

	<h2>Create Account</h2>

	<form id="createAccount" action="<?= BASE_URL ?>/createAccount/process" method="POST">
		  <label>First Name: <input type="text" name="accountfirstname" class = "inputForm"></label><br>
		  <label>Last Name: <input type="text" name="accountlastname" class = "inputForm"></label><br>
		  <label>Email: <input type="text" name="accountemail" class = "inputForm"></label> <br>
		  <label>Username: <input type="text" name="accountusername" class = "inputForm"></label><br>
		  <label>Password: <input type="password" name="accountpassword" class = "inputForm"></label><br>
		  <p>Account Type</p>
		  <input type="radio" name="accountuserType" value= "elite">Elite
		  <input type="radio" name="accountuserType" value= "regular" checked="checked">Regular<br><br>
		  <input type="submit" name="submit" value="Submit" class = "submit">
	</form>

</div>