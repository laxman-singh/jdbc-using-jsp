package gst.common.taglib;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 * @author Laxman Singh (laxman.1390@gmail.com)
 * @since 5 July, 2017
 * 
 * Custom EL Function for validating Supplier No, PAN No and GSTIN No.
 *
 */
public class CustomELFunctions {
	
	private static Pattern p;
	
	/**
	 * Method for validating Supplier Number
	 * @param supplierNo Supplier Number
	 * @return true if Supplier Number is valid otherwise false
	 */
	public static boolean isValidSupplierNo(String supplierNo) {
		
		p =Pattern.compile("^\\d+$");
		Matcher m = p.matcher(supplierNo);
		return m.matches();
	}
	
	/**
	 * Method for validating PAN Number
	 * @param panNo PAN Number
	 * @return true if PAN Number is valid otherwise false
	 */
	public static boolean isValidPan(String panNo) {
		
		p =Pattern.compile("[A-Z]{5}[0-9]{4}[A-Z]{1}");
		Matcher m = p.matcher(panNo.toUpperCase());
		return m.matches();
	}
	
	/**
	 * Method for validating GSTIN
	 * @param gstin GSTIN
	 * @return true if GSTIN is valid otherwise false
	 */
	public static boolean isValidGstin(String gstin) {
		
		p =Pattern.compile("[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9_A-Z]{1}");
		Matcher m = p.matcher(gstin.toUpperCase());
		return m.matches();
	}

}
