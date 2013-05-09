with simple_io;
use simple_io;

package body mstring is

  function CreateChaine(S: string) return chaine is
      
      c: chaine(S'length);
      
      begin
	   c.text := S;

	   return c;
      end CreateChaine;
      
     procedure Put(c: chaine) is
	  begin
	  
	  Put(c.text(1..c.L));
	  
     end Put;
     
     procedure Put_line(c: chaine) is
	begin
	  
	  Put_line(c.text);
	
     end Put_line;
     
    procedure Get_line(c: out chaine) is
	s: string(l_chaine'range);
	l: l_chaine;
	    
	begin
	    
	   get_line(s,l);
	      
	   c:= CreateChaine(s(1..l));
       
    end Get_line;
     
    function length(c: chaine)return l_chaine is
	 begin
	      
	   return c.L;
    end length;

  procedure toString(c: in chaine; s: out string; l: out l_chaine) is 
      st: string(s'First..s'First + c.L -1 ) := c.text;
      
      begin
	    s(st'Range) := st(st'Range);
	    l := c.L;
      
  end toString;
  
  procedure concat(c: in out chaine; s: in string) is
      ch: chaine(c.L + s'length);
      
      begin
	  ch.Text:= c.Text&s;
	  c := ch;
      
  
  end concat;
  
  function "+"(c: chaine; s: string) return chaine is
      ch : chaine := c;
      
      begin
	concat(ch,s);
	
	return ch;
      
  end "+";

  function "+"(s: string; c: chaine) return chaine is
      ch: chaine :=CreateChaine(s) + c;
      
      begin
      
      return ch;
      
  end "+";
  
  function "+"(c1, c2: chaine) return chaine is
      ch : chaine := c1;
      
      begin
	concat(ch, c2.text);
      return ch;
      
  end "+";
  
  function "+"(s1: string; s2: string) return chaine is
      begin
	return CreateChaine(s1) + s2;
  end "+";

  
  function contains(c: chaine; s: string) return boolean is
      contained: boolean:= FALSE ;
      i: integer := 1;
      
      begin
	while(i+s'length <= c.L+1 AND NOT contained) loop
	  contained := (c.text(i..i+s'length-1) = s(s'range));
	  i := i + 1;
	end loop;
      
	return contained;
      
  end contains;
  
  function contains(c, s: chaine) return boolean is
      begin
      
      return contains(c, s.text);
  end contains;

  function trimLeft(c: chaine) return chaine is

      i: l_chaine := 1;
      ch: chaine;
      begin

	  while(i <= c.L AND THEN c.text(i) = ' ') loop
	    i := i +1;
	  end loop;
	    
	  if(i < c.L) then
	      ch := CreateChaine(c.text(i..c.L));
	  end if;
	  
	  return ch;
  end trimLeft;
  
  function trimRight(c: chaine) return chaine is

      i: l_chaine := c.L;
      
      begin

	  while(c.text(i) = ' ' AND i > 0) loop
	    i := i -1;
	  end loop;
      
	  return CreateChaine(c.text(1..i));
  end trimRight;
  
  function substring(c: chaine; debut, fin: l_chaine) return chaine is
	
	ch: chaine := c;
	
	begin
	
	if(debut <= fin) then
	  if(debut <= c.L AND THEN fin <= c.L) then
	    ch := CreateChaine(c.text(debut..fin));
	  end if;
	
	end if;
	
	return ch;
	
  end substring;
  
  function replaceChar(c: chaine; caracRecherche, caracRempl : character) return chaine is
      ch: chaine := c;
      
      begin
	
	for I IN 1..c.L loop
	  if(ch.text(I) = caracRecherche) then
	    ch.text(I) := caracRempl;
	  end if;
	end loop;
	
      return ch;
  
  end replaceChar;
  
  function startWith(c: chaine; motif: chaine) return boolean is
  
		tmp : chaine := trimLeft(c);
		motifTmp: chaine := trimLeft(motif);
  
		begin
		
			tmp := substring(tmp, 1, length(motifTmp));
			
			return contains(tmp, motif);
		
			
  
  end startWith;
  
  function startWith(c: chaine; motif: string) return boolean is
		begin
		
			return startWith(c, CreateChaine(motif));
		
	end startWith;
  
  function strpos(c: chaine; motif: character) return indice_chaine is
		pos: indice_chaine := 0;
		i:l_chaine := 1;
		begin
		
		while(c.text(i) /= motif and i < c.L) loop
			i := i+1;
		end loop;
		
		if(c.text(i) = motif) then
			pos := i;
		end if;
		
		return pos;
	end strpos;
  
	function replaceStr(depart, recherche, remplace : chaine) return chaine is
		
		i: l_chaine := 1;
		c: chaine := depart;
		tmp1, tmp2 : chaine;
		begin
		
			if(depart.L = recherche.L)then
				return remplace;
			end if;
		
			while (i+recherche.L <= c.L+1) loop
				if(c.text(i..i+recherche.L-1) = recherche.text) then
					tmp1 := substring(c, 1, i-1);
					if(i+recherche.L <= c.L)then
						tmp2 := substring(c, i+recherche.L, c.L);
						c := tmp1 + remplace + tmp2;
					else
						c := tmp1 + remplace;
					end if;
					
					i := i+remplace.L;
				else
					i := i+1;
				end if;
			end loop;
			return c;
	end replaceStr;
  
	function replaceStr(depart,recherche: chaine; remplace: string) return chaine is
		begin
			return replaceStr(depart, recherche, CreateChaine(remplace));
	end replaceStr;
  
	function replaceStr(depart: chaine; recherche, remplace: string) return chaine is
		begin
			return replaceStr(depart, CreateChaine(recherche), CreateChaine(remplace));
	end replaceStr;
	
	function replaceStr(depart, recherche, remplace: string) return chaine is
		begin
			return replaceStr(CreateChaine(depart), CreateChaine(recherche), CreateChaine(remplace));
	end replaceStr;
	
	function replaceStr(depart: chaine; recherche: string; remplace: chaine) return chaine is
		begin
			return replaceStr(depart, CreateChaine(recherche), remplace);
	end replaceStr;
	
	function replaceStr(depart: string; recherche: chaine; remplace: string) return chaine is
		begin
			return replaceStr( CreateChaine(depart),recherche,  CreateChaine(remplace));
	end replaceStr;
	
end mstring;







