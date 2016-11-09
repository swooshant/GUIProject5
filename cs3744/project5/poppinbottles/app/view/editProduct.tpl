<div id="bodyWrapper">

	<h2>Edit Product</h2>

	<form id="edit-product" action="<?= BASE_URL ?>/products/edit/<?= $id ?>/process" method="POST">
		<label>Wine Title:<br> <input type="text" name="WineTitle" value="<?= $product->get('WineTitle') ?>"></label>
		<br><br>
		<label>ShortDesc:<br> <textarea name="ShortDesc"><?= $product->get('ShortDesc') ?></textarea></label>
		<br><br>
		<label>LongDesc:<br> <textarea name="LongDesc"><?= $product->get('LongDesc') ?></textarea></label>
		<br><br>
		<label>Volumes:<br> <input type="text" name="Volumes" value="<?= $product->get('Volumes') ?>"></label>
		<br><br>
		<label>Price ($):<br> <input type="text" name="Price" value="<?= $product->get('Price') ?>"></label>
		<br><br>
		<label>Rating:<br> <input type="text" name="Rating" value="<?= $product->get('Rating') ?>"></label>
		<br><br>
		<label>Image URL:<br> <input type="text" name="Img_Url" value="<?= $product->get('Img_Url') ?>"></label>
		<br><br>
		<input type="submit" class="submit" id="saveEdits" name="submit" value="Save Changes">

	</form>

</div>
