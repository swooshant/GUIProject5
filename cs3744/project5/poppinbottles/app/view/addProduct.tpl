<?php if(isset($_SESSION['userID'])): ?>
<div id="bodyWrapper">

	<h2>Add products</h2>

	<form id="edit-product" action="<?= BASE_URL ?>/products/addItem/process" method="POST">

		<label>Wine Title: <br> <input type="text" name="WineTitle" ></label>
		<br><br><br>
		<label>ShortDesc: <br> <textarea name="ShortDesc"></textarea></label>
		<br><br><br>
		<label>LongDesc: <br><textarea name="LongDesc"></textarea></label>
		<br><br><br>
		<label>Volumes: <br><input type="text" name="Volumes" ></label>
		<br><br><br>
		<label>Price ($): <br><input type="text" name="Price" ></label>
		<br><br><br>
		<label>Rating:<br> <input type="text" name="Rating" ></label>
		<br><br><br>
		<label>Image URL: <br><input type="text" name="Img_Url"></label>
		<br><br><br>
		<input type="submit" class="submit" id="addProduct" name="submit" value="Save Changes">

	</form>
	<?php else: ?>

  	<h3> Admin Page ONLY! </h3>

	<?php endif; ?>

</div>
