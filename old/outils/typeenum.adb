with simple_io;
use simple_io;
package body typeEnum is

	procedure put(elt: montype)is
		begin
	
		put(montype'image(elt));
	
	end put;

	procedure put_line(elt: montype)is
		begin
	
		put_line(montype'image(elt));
	
	end put_line;
	
	
	procedure get(elt: out montype)is
		S: String(1..100);
		L_S: Integer;	
		begin
	
		Get_Line(S,L_S);
		elt:=montype'Value(S(1..L_S));

	end get;

	procedure getSecure(elt: out montype)is
		S: String(1..100);
		L_S: Integer;	
		begin
	
		loop
			begin
				Get_Line(S,L_S);
				elt:=montype'Value(S(1..L_S));
				exit;
				exception
					when others =>	put_line("Erreur de type, entrez une valeur correcte !");
			end;
		end loop;

	end getSecure;
	
	
	procedure get_line(elt: out montype)is
		begin
		get(elt);
	
	end get_line;
	
	procedure succ(elt: in out montype)is
		begin
		
		if(elt = montype'last)then
			elt := montype'first;
		else
			elt := montype'succ(elt);
		end if;
		
	end succ;
	
	function succ(elt: montype) return montype is
		
		tmp: montype := elt;
		
		begin
		
		succ(tmp);
		return tmp;
		
	end succ;
	
	procedure pred(elt: in out montype)is
		begin
		
		if(elt = montype'first)then
			elt := montype'last;
		else
			elt := montype'pred(elt);
		end if;
		
	end pred;	
	
	function pred(elt: montype) return montype is
		
		tmp: montype := elt;
		
		begin
		
		pred(tmp);
		return tmp;
		
	end pred;	
	
	
end typeEnum;