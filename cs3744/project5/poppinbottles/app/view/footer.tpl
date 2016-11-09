		<h4 id="stayConn"> Stay Connected! </h4>
		
		<div id="footer">
			<div id="socialMedia">
				<!-- image taken from facebooks website -->
				<a href="http://facebook.com">
				<img class="socialm" src="<?= BASE_URL ?>/public/img/facebook.png" alt="facebook icon">
				<h5 class="social"> Like BottleUp On Facebook! </h5>
				</a>
				<!-- image taken from twitters website -->
				<a href="http://twitter.com">
				<img class="socialm" src="<?= BASE_URL ?>/public/img/twitter.png" alt="twitter icon">
				<h5 class="social"> Follow BottleUp On Twitter! </h5>
				</a>
			</div>
			<div id="contact">
				<h3> Contact </h3>
				Email: bottleUp@vt.edu <br> <br>
				Phone: 111-111-1111  <br> <br>
				Location: 1234 Random Street, RandomCity, CA 90210 
			</div>
			<div id="newsletter">
				<h3> Sign Up For The NewsLetter </h3>
				<form action="<?= BASE_URL ?>/processNewsLetter/"" method="POST">
					<input type="text" class="news inputForm name" name="name" placeholder="Name: ">
					<br>
	  				<input type="email" class="news inputForm email" name="email" placeholder="Email: "> 
	  				<br>
	  				<input type = "submit" name="newsSubmit" value="Submit" class="submit">
				</form>
			</div>
		</div>
		<h4 id="copyright"> Copyright BottleUp </h4>
	</body>
</html>