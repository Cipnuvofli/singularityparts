<div id="loginwindow">
<h2>Customer Mode</h2>
<ul>
	<?php foreach($customer_controller_arr as $controller): ?>
		<?php 
			$ctrl_link_name=$controller['link_name'];
			$ctrl_print_name=$controller['print_name'];
		?>
		<li><?php echo("<a href=\"$ctrl_link_name\">$ctrl_print_name</a>"); ?></li>
	<?php endforeach; ?>
</ul>
</div>

<div id="loginwindow">
<h2>Store Mode</h2>
<ul>
	<?php foreach($store_controller_arr as $controller): ?>
		<?php 
			$ctrl_link_name=$controller['link_name'];
			$ctrl_print_name=$controller['print_name'];
		?>
		<li><?php echo("<a href=\"$ctrl_link_name\">$ctrl_print_name</a>"); ?></li>
	<?php endforeach; ?>
</ul>
</div>