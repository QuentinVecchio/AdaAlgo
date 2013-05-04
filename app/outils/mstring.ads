package mstring is

  type chaine is private;
  subtype l_chaine is Integer range 1..1000;
  
  
  function CreateChaine(S: string) return chaine;
  
  procedure Put(c: chaine);
  
  procedure Put_line(c: chaine);
  
  procedure Get_line(c: out chaine);
 
  function length(c: chaine)return l_chaine;
  
  procedure concat(c: in out chaine; s: in string);
  
  function "+"(c: chaine; s: string) return chaine;

  function "+"(s: string; c: chaine) return chaine;
  
  function "+"(s1, s2: string) return chaine;
  
  function "+"(c1, c2: chaine) return chaine;
  
  procedure toString(c: in chaine; s: out string; l: out l_chaine);
  
  function contains(c: chaine; s: string) return boolean;
  
  function contains(c, s: chaine) return boolean;
  
  function trimLeft(c: chaine) return chaine;
  
  function trimRight(c: chaine) return chaine;
  
  function substring(c: chaine; debut, fin: l_chaine) return chaine;
  
  function replaceChar(c: chaine; caracRecherche, caracRempl : character) return chaine;
  
  function startWith(c: chaine; motif: chaine) return boolean;
 
  function startWith(c: chaine; motif: string) return boolean;
  
  private
  
    type chaine(L: l_chaine:= 1) is record
	
	text: String(1..L);
    end record;
end mstring;