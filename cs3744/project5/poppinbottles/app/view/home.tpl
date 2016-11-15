	<div id="bodyWrapper">
		<div class="headerpic">

	 		<!-- source: http://www.vgulp.com/blog/2015-03-29/Top-Wine-Grape-Varieties/#.V-jgzygrJ4c -->

	 		<img src="<?= BASE_URL ?>/public/img/grapeheader.jpg" alt="Grapes header picture"/>
	 		<p>	
				Welcome to BottleUp, a site meant for the most experienced individuals in wine and the beginner. In a world where there millions of different selections, it can become overwhelming to find something you like. We aim to help you in this process by providing a clear layout and concise information that will aid in your final decision. We also have our own brand of wine which we grow and bottle at our company owned vineyards. Every wine bottle comes with a very detailed description on it's product page. There are also reviews from previous buyers that can help give a real world experience of the wine. 
			</p>
				
		</div>
		 
		 <h3 id="topRated"> Top Rated Wines! </h3>
		 <div class="browseContent" id="homepageBrowser">
		 	<?php while($row = mysql_fetch_assoc($result)): ?>
					<!-- All descriptions, wine names and images are from TotalWine.com -->
					<div class="product">
					<form action="<?= BASE_URL ?>/products/processEditDel/<?= $row['id'] ?>" method="POST" >
						<a href="<?= BASE_URL ?>/products/view/<?= $row['id'] ?>">
							<img class="product-image" src="<?= BASE_URL ?>/public/img/<?= $row['Img_Url'] ?>" alt="<?= $row['WineTitle'] ?>" />
							<h3><?= $row['WineTitle'] ?></h3>
						</a>
					<!--	<button class="submit" type="button" value="cartPressed" onclick="<?php $this->addToCart ?>"> Add to Cart</button> -->
						<p><?= $row['ShortDesc'] ?></p>
						<p class="price"><?= $row['Price'] ?></p>
						<?php if(isset($_SESSION['admin']) && $_SESSION['admin'] == 1): ?>
							<button class="submit" name="edit" value="editPressed" >Edit</button>
							<button class="submit" name="delete" onclick="return confirm('Are you sure you want to delete this item?');" value="deletePressed">Delete</button>
						<?php elseif(isset($_SESSION['elite']) && $_SESSION['elite'] == 1 && ($_SESSION['userID'] == $row['Creator_Id'])): ?>							
							<button class="submit" name="edit" value="editPressed" >Edit</button>
							<button class="submit" name="delete" onclick="return confirm('Are you sure you want to delete this item?');" value="deletePressed">Delete</button>
						<?php endif; ?>
					</form>
					</div>
				
			<?php endwhile; ?>	
		</div>
		</div>
		<div id="vineyards">
			<img class="Vineyard-image" src="<?= BASE_URL ?>/public/img/vin1.jpg" id="vineImag"	alt="First vineyard operated by BottleUp. Located in Nappa Valley" />			
		</div>
		<div id="buttonBar">
			<input type="submit" value="Nappa 1" class="submit vinBut" id="vin1button"/>
			<input type="submit" value="Nappa 2" class="submit vinBut" id="vin2button"/>
			<input type="submit" value="Virginia" class="submit vinBut" id="vin3button"/>
		</div>
		
		<?php if(isset($_SESSION['userID'])): ?>

			<h2 class="aboutUsHeadings" > Activity Feed </h2> 

			<?php if(count($events) == 0): ?>
				<p>No recent activity.</p>
			<?php else: ?>

			<ul>
				<?php foreach($events as $event): ?>
						<?php if ($event != null): ?>
			    			<li style="list-style: none; color:blue; font-weight: bold;" ><?= formatEvent($event) ?></li>
			    		<?php endif; ?>
			  	<?php endforeach; ?>
			</ul>

			<?php endif; ?>
		
		<?php endif; ?>
	
