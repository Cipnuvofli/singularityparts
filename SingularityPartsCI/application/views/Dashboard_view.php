
<!-- Customer mode -->
<?php if(isset($customer_controller_arr)): ?>
	<div id="dashboard_customer">
		<ul>
			<?php foreach($customer_controller_arr as $controller): ?>
				<?php 
					$ctrl_link_name=$controller['link_name'];
					$ctrl_print_name=$controller['print_name'];
				?>
				<li><?php echo anchor($ctrl_link_name, $ctrl_print_name, ''); ?></li>

			<?php endforeach; ?>
		</ul>
	</div>
<?php endif; ?>

<!-- store mode -->
<?php if(isset($store_controller_arr)): ?>
	<div id="dashboard_store">
		<ul>
			<?php foreach($store_controller_arr as $controller): ?>
				<?php 
					$ctrl_link_name=$controller['link_name'];
					$ctrl_print_name=$controller['print_name'];
				?>
				<li><?php echo anchor($ctrl_link_name, $ctrl_print_name, ''); ?></li>
			<?php endforeach; ?>
		</ul>
	</div>
<?php endif; ?>