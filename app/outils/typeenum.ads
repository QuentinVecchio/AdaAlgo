generic

type montype is (<>);

package typeEnum is

	--
	-- Surcharge de put et get pour le type énuméré
	--
	procedure put(elt: montype);
	
	procedure put_line(elt: montype);
	
	procedure get(elt: out montype);
	
	--
	-- Permet l'acquisition sécurisé de l'élément, gestion de l'exception
	--
	procedure getSecure(elt: out montype);
	
	--
	-- Appel get
	--
	procedure get_line(elt: out montype);
	
	
	--
	-- Fonction et procédure pour succ et pred
	-- Version fonction appelle version procédure, évite redondance du code
	--
	
	procedure succ(elt: in out montype);
	
	function succ(elt: montype) return montype;
	
	procedure pred(elt: in out montype);
	
	function pred(elt: montype) return montype;
	
end typeEnum;