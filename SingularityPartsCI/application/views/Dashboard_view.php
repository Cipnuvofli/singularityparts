
<div id="dashboard">
<ul>
	<?php foreach($controller_arr as $controller): ?>
		<?php 
			$ctrl_link_name=$controller['link_name'];
			$ctrl_print_name=$controller['print_name'];
		?>
		<li><?php echo("<a href=\"$ctrl_link_name\">$ctrl_print_name</a>"); ?></li>
	<?php endforeach; ?>
</ul>
</div>