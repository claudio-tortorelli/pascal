{                               ATTENZIONE:                                 }
{Non mi assumo responsabilit… sul funzionamento o sull'uso di questa unit.  }
{Desidero evidenziare inoltre che Š nata in ambito didattico, Š soggetta a  }
{cambiamenti e correzioni e nella maggior parte dei casi necessita un lavoro}
{di adeguamento per essere applicata ai casi pratici.}
{N.B. Come default le procedure sono costruite su dati di forma Integer.}

UNIT heap;

{Procedure per la gestione di heap e alberi parzialmente ordinati}

INTERFACE
uses crt;
const rig=1;     {serve per la stampa dell'albero}
      col=30;    {serve per la stampa dell'albero}
      maxheap=20;{contiene i dati dello heap}

type tipokey=integer;
type vettore=array [1..maxheap] of tipokey;
type apo=^nodo;
     nodo=record
          key:tipokey;
          left,right:apo;
          end;
type heap_space=record
                N:0..maxheap;{se N=0 allora heap=vuoto}
                Vet:array [1..maxheap] of tipokey;
                end;
var vetto:vettore;
    hh:heap_space;
    x,y,temp,ris:integer;

{--------------------}


Procedure Scambia (a,b:integer;var rec:heap_space);
Procedure Solleva (a:integer;var rec:heap_space);
Procedure Inserzione(x:tipokey;var rec:heap_space);
procedure Spingi(a:integer;var rec:Heap_space);
Procedure Cancella_max(var max:tipokey;var rec:heap_space);
Procedure crea_Apo (a:integer;rec:heap_space;var tree:apo);
Procedure Stampa_heap (rec:heap_space);
Procedure Visualizza(tree:apo;rig,col:integer);
Procedure Vet_heap_ric (vetto:vettore;var heap:heap_space);

{---------------------}

IMPLEMENTATION

{4)                     COMPITO 5-9-97}
{Procedura per inserire in uno heap un elemento e ordinarlo, analoga a
solleva e considerando lo heap non come record
Procedure Insert (var vet:vettore;var k:integer;x:tipokey);
Procedure Solleva(var vet:vettore;i:integer);
var temp:integer;
    temp2:tipokey;
begin
ERRORE : DIMENTICARSI DI if i>0 then begin
     temp:=i div 2;
     if vet[temp]<vet[i] then
                           begin
                             temp2:=vet[temp];
                             vet[temp]:=vet[i];
                             vet[i]:=temp2;
                             solleva(vet,temp);
                           end;
end;
begin
     k:=k+1;
     vet[k]:=x;
     solleva(vet,k);
end;}


{4) COMPITO DEL 16/4/98
Procedura che dato un vettore Vet lo trasforma in uno heap}
{dato numero dati vet=heap}
{Versione Iterativa: Š pi— efficiente solo se il vettore Š
ordinato in quanto Š possibile allora ridurre il numero di confronti
sul vettore ad ogni passaggio
Procedure Vet_heap_ite (vetto:vettore;var heap:heap_space);
var x,y,temp:integer;
begin
     for x:=1 to maxheap do begin
                              temp:=0;
                              for y:=1 to maxheap do if temp<vetto[y] then temp:=vetto[y];
                              heap.n:=heap.n+1;
                              heap.vet[heap.n]:=temp;
                            end;
end;}

Procedure Vet_heap_ric (vetto:vettore;var heap:heap_space);
var x,y,temp:integer;
    Procedure solleva(x:integer;var heap:heap_space);
    var i,tem:integer;
    begin
         if x>1 then begin
                       i:=(x div 2);
                       if heap.vet[i] < heap.vet[x] then begin
                                                         temp:=heap.vet[i];
                                                         heap.vet[i]:=heap.vet[x];
                                                         heap.vet[x]:=temp;
                                                         solleva (i,heap);
                                                       end;
                     end;
     end;
begin
     for x:=1 to maxheap do begin
                             heap.n:=heap.n+1;
                             heap.vet[heap.n]:=vetto[x];
                             solleva(heap.n,heap);
                           end;
end;

{Procedura che stampa un albero in ordine anticipato e lo disegna}
{dato spiaz=35 e liv=1}
Procedure Visualizza(tree:apo;rig,col:integer);
var temp:tipokey;
begin
     if tree=nil then begin
                      if (rig>1) and (rig<4) then begin
                                                  gotoxy(col+3,rig);
                                                  write('nil');
                                                  end
                                 else if rig>=4 then begin
                                                     gotoxy(col+2,rig);
                                                     write('nil');
                                                     end
                                                 else begin
                                                      gotoxy(col+4,rig);
                                                      write('nil');
                                                      end;
                       end
                 else begin
                      if (rig>1) and (rig<4) then begin
                                    gotoxy(col,rig);
                                    write ('/----',tree^.key,'----\');
                                    gotoxy(col,rig+1);
                                    write('|');
                                    gotoxy(col+11,rig+1);
                                    write('|');
                                    visualizza(tree^.left,rig+2,col-5);
                                    visualizza(tree^.right,rig+2,col+8);
                                    end
                               else if rig>=4 then begin
                                                   gotoxy(col,rig);
                                                   write ('/--',tree^.key,'--\');
                                                   gotoxy(col,rig+1);
                                                   write('|');
                                                   gotoxy(col+7,rig+1);
                                                   write('|');
                                                   visualizza(tree^.left,rig+2,col-3);
                                                   visualizza(tree^.right,rig+2,col+4);
                                                   end
                                              else begin
                                              gotoxy(col,rig);
                                              write ('/--------',tree^.key,'--------\');
                                              gotoxy(col,rig+1);
                                              write('|');
                                              gotoxy(col+20,rig+1);
                                              write('|');
                                              visualizza(tree^.left,rig+2,col-5);
                                              visualizza(tree^.right,rig+2,col+15);
                                              end;
                      end;
end;

{Procedura che stampa il vettore heap}
Procedure Stampa_heap (rec:heap_space);
var a:integer;
begin
     a:=1;
     while (rec.n<>0) and (a<=rec.n) do begin
                                       write(rec.vet[a],' ');
                                       a:=a+1;
                                       end;
end;

{Procedura che genera dall'heap l'equivalente albero parzialente ordinato}
{dato a indice sull'heap=1}
Procedure crea_Apo (a:integer;rec:heap_space;var tree:apo);
var tmp:apo;
begin
     if (rec.n<>0) and (a<rec.n) then begin {heap non vuoto e indice < di N}
                 new(tmp);
                 tmp^.key:=rec.vet[a];
                 tmp^.left:=nil;
                 tmp^.right:=nil;
                 crea_apo((2*a),rec,tmp^.left);
                 crea_apo((2*a)+1,rec,tmp^.right);
                 tree:=tmp;
                 end;
end;

{Procedura che dato uo heap e un indice a, spinge l'elemento di
indice a dentro il vettore fino a che non risulta ordinato}
{dato a=1}
procedure Spingi(a:integer;var rec:Heap_space);
var figlio:integer;
begin
     figlio:=2*a;
     if figlio<=rec.n then begin {il figlio esiste}
                      if (figlio+1)<=rec.n then {esiste anche il successivo}
                           if rec.vet[figlio+1]>rec.vet[figlio] then figlio:=figlio+1;
                      if rec.vet[a]<rec.vet[figlio] then begin
                                                    scambia(a,figlio,rec);
                                                    spingi(figlio,rec);
                                                    end;
                      end;
end;

{Procedura che cancella il massimo elemento dell heap e lo restituisce in max}
Procedure Cancella_max(var max:tipokey;var rec:heap_space);
begin
     max:=rec.vet[1];
     rec.vet[1]:=rec.vet[rec.n];
     rec.n:=rec.n-1;
     spingi (1,rec);
end;

{Procedura che dato un heap rec e una chiave x inserisce x in rec}
Procedure Inserzione(x:tipokey;var rec:heap_space);
begin
     rec.n:=rec.n+1;
     rec.vet[rec.N]:=x;
     solleva(rec.n,rec);
end;

{Procedura che confronta un elemento di indice a con suo padre di indice a/2
 e lo solleva se maggiore}
Procedure Solleva (a:integer;var rec:heap_space);
begin
     if a>1 then begin
                 if rec.vet[a]>rec.vet[a div 2] then begin
                                                scambia (a,a div 2,rec);
                                                solleva (a div 2, rec);
                                                end;
                 end;
end;

{Procedura che dato il vettore heap e due indici relativi a elementi
in relazione tra loro, ne scambia il contenuto}
Procedure Scambia (a,b:integer;var rec:heap_space);
var temp:tipokey;
begin
     temp:=rec.vet[a];
     rec.vet[a]:=rec.vet[b];
     rec.vet[b]:=temp;
end;

end. {UNIT}
