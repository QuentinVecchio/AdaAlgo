

generic

type Elt is <>;

package tableau is
	
	type T_Elt is private;
	type T_ACCESS_T_ELT is ACCESS T_Elt;
	
	
	private;
	
	
		type T_Elt is record
		
			bloc: Elt;
			prochain: T_ACCESS_T_ELT;
		
		end record;

end Tableau;
