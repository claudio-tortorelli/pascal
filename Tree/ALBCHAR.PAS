{                               ATTENZIONE:                                 }
{Non mi assumo responsabilit… sul funzionamento o sull'uso di questa unit.  }
{Desidero evidenziare inoltre che Š nata in ambito didattico, Š soggetta a  }
{cambiamenti e correzioni e nella maggior parte dei casi necessita un lavoro}
{di adeguamento per essere applicata ai casi pratici.}
{N.B. Come default le procedure sono costruite su dati di forma Integer.}

UNIT Albchar;

{Procedure per la gestione di alberi binari di ricerca, alberi AB, alberi
generici- soluzione specifica per alberi di chiavi alfabetiche}

INTERFACE
uses crt;
const rig=1;     {serve per la stampa dell'albero}
      col=30;    {serve per la stampa dell'albero}
      numdati=10;{dati da permutare in shuffle}

type tipokey=char;
Type lista=^nodolist;
     nodolist=record
               key:tipokey;
               next:lista;
              end;
type btchar=^charn;  {alberi binari di lettere}
     charn=record
              key:char;
              left,right:btchar;
           end;
type vettore=array [1..numdati] of integer;
type permutaz=array [1..numdati] of tipokey;
var vet:permutaz;{serve per lo shuffle}


Procedure Insert_node_bin(x:tipokey; var tree:btchar);
Procedure STampa_tree_antic(tree:btchar;rig,col:integer);
Procedure Insert_node(x:tipokey;var tree:btchar);
Procedure Cerca_key(tree:btchar;x:tipokey;var trovato:boolean;var ris:tipokey);
Procedure Del_t_fromkey (x:tipokey;var tree:btchar;var trovato:boolean);
Procedure Stampa_antic2(tree:btchar);
Procedure Punta_key(tree:btchar;x:tipokey; var node:btchar);
Procedure Punta_key_bin(tree:btchar;x:tipokey; var node:btchar);
Procedure Cancellaxy (x,y:tipokey;var tree:btchar);
Procedure Conta_nodi(tree:btchar;ris:integer);
Procedure Conta_nodi_bilanciati(tree:btchar;var count:integer;var num:integer);
Function Isfoglia(tree:btchar):boolean;
Procedure Autunno (var tree:btchar);
Function Crea_radice(x:tipokey):btchar;
Function Min_tree_bin (tree:btchar):tipokey;
Function Restituisci_min (var tree:btchar):tipokey;
Procedure Cancella_x_bin (x:tipokey;var tree:btchar);
Procedure Genera_da_vet (i,j:integer;var tree:btchar;var A:permutaz);
Procedure Taglia_da_liv (n,liv:integer;var tree:btchar);
Procedure Trasforma(tree:btchar;var newt:btchar);
Procedure Erode (var tree:btchar);
Procedure Fatt_ram(tree:btchar;var ram:integer);
Procedure Cancella_xy_AB (x,y:tipokey;var tree:btchar);
Procedure Maxliv_x (Tree:btchar; x:tipokey; liv:integer; var risult:integer);
Procedure Contorno (x:tipokey;var tree:btchar);
Procedure Cerca_max_Antenato(x:tipokey;tree:btchar;maxtemp:tipokey;var max:tipokey);
Procedure Gen_lista (tree:btchar;var pippo:lista);
Procedure Angelo_Vendicatore (var tree:btchar);
Procedure Fattoram(t:btchar;var risult:integer);
Procedure Parent (var tree:btchar);

IMPLEMENTATION
{                               COMPITO DEL 23/6/98
1) Procedura che dato un albero binario t della forma figlio fratello,
contenente chiavi alfabetiche, restituisce l'albero modificato, aggiungendo
per ogni nodo non foglia come primo figlio ( e come ultimo figlio )}
{tipokey=char}
Procedure Parent (var tree:btchar);
var atonda,ctonda,temp,frat:btchar;
begin
     if tree<>nil then
                    if tree^.left<>nil then
                                         begin
                                           new(atonda);
                                           atonda^.key:='(';
                                           atonda^.right:=tree^.left;
                                           atonda^.left:=nil;
                                           tree^.left:=atonda;
                                           temp:=tree^.left^.right;
                                           frat:=tree^.left;
                                           while temp<>nil do
                                                           begin
                                                             parent(temp);
                                                             frat:=temp;
                                                             temp:=temp^.right;
                                                           end;
                                           new(temp);
                                           temp^.key:=')';
                                           temp^.right:=nil;
                                           temp^.left:=nil;
                                           frat^.right:=temp;
                                         end;
end;

{                               COMPITO 11/7/97
1)Procedura che dato un albero binario t della forma figlio-fratello ne
calcola il fattore di ramificazione}
{risult=0}
Procedure Fattoram(t:btchar;var risult:integer);
var figli:btchar;
    tempris:integer;
begin
     if t<>nil then
                 begin
                   tempris:=0;
                   figli:=t^.left;
                   while figli<>nil do
                                     begin
                                       tempris:=tempris+1;
                                       figli:=figli^.right;
                                     end;
                   if tempris>risult then risult:=tempris;
                   while figli<>nil do
                                     begin
                                       fattoram(figli,risult);
                                       figli:=figli^.right;
                                     end;
                 end;
end;

{                               COMPITO 5/9/97
1) Procedura che dato un albero binario T (figlio,fratello), cancella
il primogenito di ogni nodo con tutto il relativo sottoalbero e se la
radice Š una foglia restituisce l'albero vuoto}
Procedure Angelo_Vendicatore (var tree:btchar);
var frat:btchar;
begin
  if tree<>nil then {Albero vuoto}
                 begin
                   if tree^.left<>nil then {then tree:=tree^.right {sola radice o senza figli}
                        begin {Ha almeno il primogenito}
                          tree^.left:=tree^.left^.right;{steccola primogenito}
                          frat:=tree^.left;{pensa a suo fratello}
                          {se c'Š il fratello...}
                          while frat<>nil do {...e finchŠ ci sono fratelli}
                                           begin {fai lo stesso coi loro figli!}
                                             Angelo_vendicatore(frat);
                                             frat:=frat^.right;
                                           end;
                        end;  {nei secoli dei secoli!}
                   end;
end;

{1)                             COMPITO 5/2/98  - OK
Dato un albero binario Tree di interi distinti, dato x intero, restituisce
il pi— grande fra gli antenati propri di x, se x occorre nell'albero e
non Š la radice, 0 altrimenti.}
{max=0, maxtemp=0}
Procedure Cerca_max_Antenato(x:tipokey;tree:btchar;maxtemp:tipokey;var max:tipokey);
begin
     if tree<>nil then begin
                         if tree^.key=x then max:=maxtemp
                                     else begin
                                            if tree^.key>maxtemp then maxtemp:=tree^.key;
                                            cerca_max_antenato(x,tree^.left,maxtemp,max);
                                            cerca_max_antenato(x,tree^.right,maxtemp,max);
                                          end;
                       end;
end;

{2)                             COMPITO 5/2/98 - OK
Procedura che dato un albero Binario Tree, genera una lista ordinata
degli elementi dell'albero, restituendone il puntatore alla testa}
{Data la lista pippo inizializzata a Nil}
Procedure Gen_lista (tree:btchar; var pippo:lista);
var temp:lista;
begin
     if tree<>nil then
                  begin
                    gen_lista(tree^.right,pippo);
                    new (temp);
                    temp^.key:=tree^.key;
                    temp^.next:=pippo;
                    pippo:=temp;
                    gen_lista(tree^.left,pippo);
                  end;
end;

{                               COMPITO 16/4/98 - OK
1) Procedura che dato un albero T del tipo figlio-fratello e una chiave
x restituisce il massimo livello in cui occorre x nell'albero, 0 altrimenti.}
{liv=0,risult=0}
Procedure Maxliv_x (Tree:btchar; x:tipokey; liv:integer; var risult:integer);
var temp:btchar;
begin
     if tree<>nil then begin
                         if tree^.key=x then if risult<liv then risult:=liv;
                         temp:=tree^.left; {figlio}
                         while temp<>nil do begin
                                              maxliv_x(temp,x,liv+1,risult);
                                              temp:=temp^.right;{fratello}
                                            end;
                       end;
end;

{2)                             COMPITO 16/4/98  - OK
Procedura che dato il puntatore Bt ad un albero binario e dato il numero x
aggiunga x al posto di ogni nodo esterno. Se Bt Š vuot restituisce l'albero
con la sola chiave x}
Procedure Contorno (x:tipokey;var tree:btchar);
var temp:btchar;
begin
     if tree=nil then begin
                        new(temp);
                        temp^.key:=x;
                        temp^.left:=nil;
                        temp^.right:=nil;
                        tree:=temp;
                      end
                 else begin
                        contorno(x,tree^.left);
                        contorno(x,tree^.right);
                      end;
end;

{Procedura che dato l'albero binario AB T, cerca la chiave y e se la trova
cancella x se Š suo figlio}
Procedure Cancella_xy_AB (x,y:tipokey;var tree:btchar);
var figlio,fratprec:btchar;
begin
     if tree^.key=y then begin{la radice Š y}
        figlio:=tree^.left;
        fratprec:=nil;
        while figlio<>nil do begin
                          if figlio^.key=x then begin{figlio=x}
                             if fratprec=nil then {x Š il primo figlio di y}
                                if figlio^.right<>nil then tree^.left:=figlio^.right{controlla se ha fratelli a cui puntare}
                                   else figlio:=nil
                             else fratprec^.right:=figlio^.right;{x Š presente ma non come primogenito}
                             figlio:=figlio^.right;{continua la ricerca}
                             end{if}
                           else begin {figlio<>x}
                                fratprec:=figlio;
                                figlio:=figlio^.right;
                                end;
                           end;{if}
                          end{while}
        else begin {la radice t non Š = y}
             figlio:=tree^.left;
             while figlio<>nil do begin {cerca y tra i figli}
                   cancella_xy_AB(x,y,figlio);
                   figlio:=figlio^.right;
                   end;{while}
             end;{else}
end;

{Procedura che dato l'albero Ab binario, restituisce in ram il fattore di
ramificazione:max numero di figli di un nodo.In questo caso specifico
Š un dato superfluo}
{dato ram=0}
Procedure Fatt_ram(tree:btchar;var ram:integer);
var figlio:btchar;
    temp:integer;
begin
     temp:=0;
     figlio:=tree^.left;
     while figlio<>nil do begin
          temp:=temp+1;
          figlio:=figlio^.right;
          end;
     if temp>ram then ram:=temp;
     figlio:=tree^.left;
     while figlio<>nil do begin
           fatt_ram(figlio,ram);
           figlio:=figlio^.right;
           end;
end;

{Procedura che dato un albero AB binario, cancella tutti gli ultimogeniti
di ogni nodo, non cancella i figli unici}
Procedure Erode (var tree:btchar);
var figlio,fratello:btchar;
begin
     if tree<>nil then begin
        figlio:=tree^.left;
        fratello:=nil;
        while figlio^.right<>nil do begin
              fratello:=figlio;
              figlio:=figlio^.right;
              end;
              if fratello=nil then tree^.left:=tree^.left^.right
                 else fratello^.right:=nil;
        figlio:=tree^.left;
        while figlio<>nil do begin
              erode(figlio);
              figlio:=figlio^.right;
              end;
        end;
end;

{Procedura che dato un albero binario, lo converte in un albero binario T'
della forma figlio-sinistro=figlio, figlio-destro=fratello}
Procedure Trasforma(tree:btchar;var newt:btchar);
var radix:btchar;
begin
     if tree<>nil then begin
                  new(radix);
                  radix^.key:=tree^.key;
                  radix^.left:=nil;
                  radix^.right:=nil;
                  if tree^.left=nil then trasforma (tree^.right,radix^.left)
                  else if tree^.right=nil then trasforma (tree^.left,radix^.left)
                  else begin
                       trasforma(tree^.left, radix^.left);
                       trasforma(tree^.right,radix^.left^.right);
                       end;
                  newt:=radix;
                  end;
end;

{Procedura che dato T albero, lo visita in ordine anticipato tagliando tutti
i rami oltre un certo livello n}
Procedure Taglia_da_liv (n,liv:integer;var tree:btchar);
begin
     if tree<>nil then begin
                       if liv>=n then begin
                                      tree^.left:=nil;
                                      tree^.right:=nil;
                                      end
                       else begin
                           taglia_da_liv(n,liv+1,tree^.left);
                           taglia_da_liv(n,liv+1,tree^.right);
                           end;
                       end;
end;

{Procedura che dato un vettore A preordinato, genera da questo una albero
binario di ricerca il pi— possibile bilanciato}
{dati i=1 e j=numdati}
Procedure Genera_da_vet (i,j:integer;var tree:btchar;var A:permutaz);
var m:integer;
begin
     if i<=j then begin
                  m:=(i+j) div 2;
                  new(tree);
                  tree^.key:=a[m];
                  tree^.left:=nil;
                  tree^.right:=nil;
                  genera_da_vet(i,m-1,tree^.left,a);
                  genera_da_vet(m+1,j,tree^.right,a);
                  end;
end;

{Procedura che dato un albero binario di ricerca T e una chiave x, cerca x
nell'albero e se la trova la cancella logicamente sostituendola al figlio
sinistro, al destro o se esistono entrambi al minimo del sottoalbero destro}
Procedure Cancella_x_bin (x:tipokey;var tree:btchar);
begin
     if tree<>nil then begin
        if tree^.key<x then Cancella_x_bin (x,tree^.right)
           else if tree^.key>x then Cancella_x_bin (x,tree^.left)
                else if tree^.left=nil then tree:=tree^.right
                     else if tree^.right=nil then tree:=tree^.left
                          else tree^.key:=restituisci_min(tree^.right);
     end;
end;

{FUnzione che dato un albero bin di ricerca T lo scorre lungo la dorsale
sinistra (cercando il minimo). Quando lo trova lo restituisce e cancella
logicamente il nodo sostituendolo col figlio destro}
Function Restituisci_min (var tree:btchar):tipokey;
begin
     if tree^.left=nil then begin
                            restituisci_min:=tree^.key;
                            tree:=tree^.right;
                            end
                       else restituisci_min:=restituisci_min(tree^.left);
end;


{FUnzione che dato un albero binario di ricerca restituisce il valore della
chiave minima, ? se vuoto}
Function Min_tree_bin (tree:btchar):tipokey;
begin
     if tree=nil then min_tree_bin:='?'
        else begin
               if tree^.left=nil then min_tree_bin:=tree^.key
                                 else min_tree_bin:=min_tree_bin(tree^.left);
                               end;
end;

{Funzione che data una chiave x crea un albero di radice x e figli sin e des
uguali a nil}
Function Crea_radice(x:tipokey):btchar;
var temp:btchar;
begin
     new(temp);
     temp^.key:=x;
     temp^.left:=nil;
     temp^.right:=nil;
     crea_radice:=temp;
end;

{Procedura che dato ua albero T taglia tutte le foglie}
Procedure Autunno (var tree:btchar);
begin
     if tree<>nil then begin
                       if isfoglia(tree)=true then tree:=nil
                          else begin
                               autunno(tree^.left);
                               autunno(tree^.right);
                               end;
                       end;
end;

{Funzione che prende in esame un albero e valuta se Š una foglia}
{tree<>nil}
Function Isfoglia(tree:btchar):boolean;
begin
     if tree<>nil then
                  if (tree^.left=nil) and (tree^.right=nil) then isfoglia:=true
                                      else isfoglia:=false;
end;

{Procedura che dato un albero binario t restituisce il numero dei nodi bilanciati
dell'albero}
{dato count:=0}
Procedure Conta_nodi_bilanciati(tree:btchar;var count:integer;var num:integer);
var ns,nd:integer;
begin
     if tree=nil then num:=0
        else begin
             conta_nodi_bilanciati(tree^.left,count,ns);
             conta_nodi_bilanciati(tree^.right,count,nD);
             if ns=nd then count:=count+1;
             num:=ns+nd+1;
             end;
end;

{Procedura che dato un albero restituisce il numero di nodi presenti}
{ris:=0}
Procedure Conta_nodi(tree:btchar;ris:integer);
begin
     if tree<>nil then begin
                  conta_nodi(tree^.left,ris);
                  ris:=ris+1;
                  conta_nodi(tree^.right,ris);
                  end;
end;

{Procedura che dato un albero inserisce un nodo secondo le regole degli
alberi binari di ricerca}
Procedure Insert_node_bin(x:tipokey; var tree:btchar);
begin
     if tree=nil then begin
                      new(tree);
                      tree^.key:=x;
                      tree^.left:=nil;
                      tree^.right:=nil;
                      {gotoxy(1,1);
                      write('Nodo inserito:',tree^.key,' ');}
                      end
                 else if x>tree^.key then insert_node_bin(x,tree^.right)
                                         else insert_node_bin(x,tree^.left);
end;

{Procedura che stampa un albero in ordine anticipato e lo disegna}
{dato spiaz=35 e liv=1}
Procedure STampa_tree_antic(tree:btchar;rig,col:integer);
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
                                    stampa_tree_antic(tree^.left,rig+2,col-5);
                                    stampa_tree_antic(tree^.right,rig+2,col+8);
                                    end
                               else if rig>=4 then begin
                                                   gotoxy(col,rig);
                                                   write ('/--',tree^.key,'--\');
                                                   gotoxy(col,rig+1);
                                                   write('|');
                                                   gotoxy(col+7,rig+1);
                                                   write('|');
                                                   stampa_tree_antic(tree^.left,rig+2,col-3);
                                                   stampa_tree_antic(tree^.right,rig+2,col+4);
                                                   end
                                              else begin
                                              gotoxy(col,rig);
                                              write ('/--------',tree^.key,'--------\');
                                              gotoxy(col,rig+1);
                                              write('|');
                                              gotoxy(col+20,rig+1);
                                              write('|');
                                              stampa_tree_antic(tree^.left,rig+2,col-5);
                                              stampa_tree_antic(tree^.right,rig+2,col+15);
                                              end;
                      end;
end;

{Procedura che data una certa chiave x restituisce un albero contenente
la chiave e non di ricerca. Non controlla se le chiavi sono distinte}
Procedure Insert_node (x:tipokey;var tree:btchar);
var temp:btchar;
    scegli:integer;
begin
    if tree=nil then begin
                new(temp);
                temp^.key:=x;
                temp^.left:=nil;
                temp^.right:=nil;
                tree:=temp;
                end
                else begin
                scegli:=random(2);
                case scegli of
                0:begin
                       if tree^.left=nil then insert_node(x,tree^.left)
                                  else insert_node(x,tree^.right);
                  end;
                1:begin
                       if tree^.right=nil then insert_node(x,tree^.right)
                                  else insert_node(x,tree^.left);
                  end;
                end;
                end; {else}
end;

{Procedura che cerca in un albero generico la presenza di una data chiave e
la restituisce se la trova o ? altrimenti.}
{trovato:=false}
Procedure Cerca_key (tree:btchar;x:tipokey;var trovato:boolean;var ris:tipokey);
begin
  if trovato=false then begin
     if tree^.key=x then ris:=x
        else begin
        ris:='?';
        if tree^.left<>nil then cerca_key(tree^.left,x,trovato,ris);
        if tree^.right<>nil then cerca_key(tree^.right,x,trovato,ris);
        end; {if}
     if (ris<>'?') then trovato:=true;
  end;{if}
end;

{Procedura che dato un albero T e una chiave x, se la chiave Š presente
nell'albero,  cancella il primo sottoalbero di radice x}
Procedure Del_t_fromkey (x:tipokey;var tree:btchar;var trovato:boolean);
var temp:btchar;
begin
     if tree^.key=x then begin
                         {tree^.left:=nil; Se si vogliono cancellare solo
                         tree^.right:=nil; i figli}
                         tree:=nil;
                         write('Cancellato');
                         trovato:=true;
                         readln;
                         end
                    else begin
                         if tree^.left<>nil then del_t_fromkey(x,tree^.left,trovato);
                         if (tree^.right<>nil) and (not(trovato)) then del_t_fromkey(x,tree^.right,trovato);
                         end;
end;

Procedure Stampa_antic2 (tree:btchar);
var figlio:btchar;
begin
     write (tree^.key,' ');
     figlio:=tree^.left;
     while figlio<>nil do begin
                       stampa_antic2(figlio);
                       figlio:=figlio^.right;
                       end;
end;

{Prucedura che dato un albero T, una chiave x, restituisce in node l'albero
di radice x o altrimenti nil}
{node:=nil}
Procedure Punta_key(tree:btchar;x:tipokey; var node:btchar);
begin
     if tree<>nil then begin
        if tree^.key=x then node:=tree
           else begin
                punta_key(tree^.left,x,node);
                punta_key(tree^.right,x,node);
                end;
     end;
end;

{COme punta_key solo che Š applicata ad un albero binario di ricerca e
dunque Š ottimizzata}
{node:=nil}
Procedure Punta_key_bin(tree:btchar;x:tipokey; var node:btchar);
begin
     if tree<>nil then begin
        if tree^.key=x then node:=tree
           else if tree^.key<x then punta_key_bin(tree^.right,x,node)
                   else punta_key_bin(tree^.left,x,node);
     end;
end;

{Procedura che dato un albero t cerca la chiave x, se x Š presente in T
allora verifica che il figlio sinistro e destro di x siano = a y e in
tal caso li cancella}
{dati x e y}
Procedure Cancellaxy (x,y:tipokey;var tree:btchar);
var pippo:btchar;
begin
     pippo:=nil;
     punta_key(tree,x,pippo);
     if pippo<>nil then begin
        if pippo^.left^.key=y then pippo^.left:=nil;
        if pippo^.right^.key=y then pippo^.right:=nil;
     end;
end;

end. {UNIT}
