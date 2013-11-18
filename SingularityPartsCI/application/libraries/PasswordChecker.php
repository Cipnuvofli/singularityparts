
<?php 
class PasswordChecker{

/* ================= BEGIN CONSTANTS ========================================*/
	//combos per second supercomputer
	protected $COMBOS_PER_SECOND = 100000000000000000;
	
	/*
	 * ok, so our typical attacker is not going to be a supercomputer.
	 * This is how many times slower the average attacker will be.
	 * For example, if the average attacker has 1/16 the computing resources, 
	 * you set this value to 16. 
	 */
	protected $AVERAGE_STRENGTH_COMPARISON = 16;
	
	//valid passwords MUST NOT be cracked by the average attacker in less time than this.
	protected $REQUIRED_MIN_DAYS = 90;
/* ================= END CONSTANTS ========================================*/

	
   /**
	* Validates the password 
	*/
	protected function isStrongEnoughPassword($pass)
	{
		$days_to_crack = checkStrength($pass);
		if($days_to_crack < $REQUIRED_MIN_DAYS)
		{
			return false;
		}
		return true;
	}

	/*
	 * Returns the number of days the average attacker will take to crack the password.
	 */
	protected function checkStrength($pass)
	{
		$pass_array = str_split($pass);
		$pass_unique = array_unique($pass_array);
		$alphabet_size = count($pass_unique);
		$pass_length = count($pass_array);
		$total_combos = pow($alphabet_size, $pass_length);
		
		//predict number of days to cracking
		$seconds_to_crack = $total_combos / $COMBOS_PER_SECOND;
		$days_to_crack = $seconds_to_crack / 3600 / 24;
		
		return round($days_to_crack * $AVERAGE_STRENGTH_COMPARISON);
	}
}
?>