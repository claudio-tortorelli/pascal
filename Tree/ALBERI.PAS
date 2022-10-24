{                               ATTENZIONE:                                 }
{Non mi assumo responsabilitÖ sul funzionamento o sull'uso di questa unit.  }
{Desidero evidenziare inoltre che ä nata in ambito didattico, ä soggetta a  }
{cambiamenti e correzioni e nella maggior parte dei casi necessita un lavoro}
{di adeguamento per essere applicata ai casi pratici.}
{N.B. Come default le procedure sono costruite su dati di forma Integer.}

UNIT Alberi;

{Procedure per la gestione di alberi binari di ricerca, alberi AB, alberi
generici}

INTERFACE
uses crt;
const rig=1;     {serve per la stampa dell'albero}
      col=30;    {serve per la stampa dell'albero}
      numdati=10;{dati da permutare in shuffle}

type tipokey=integer;
type btree=^nodo;
     nodo=record
          key:tipokey;
          left,right:btree;
          end;
Type lista=^nodolist;
     nodolist=record
               key:tipokey;
               next:lista;
              end;
type vettore=array [1..numdati] of integer;
type permutaz=array [1..numdati] of tipokey;
var vet:permutaz;{serve per lo shuffle}


Procedure Insert_node_bin(x:tipokey; var tree:btree);
Procedure STampa_tree_antic(tree:btree;rig,col:integer);
Procedure Cerca_max_bin(tree:btree;var max:tipokey);
Procedure Shuffle (var vet:permutaz);
Procedure Cerca_key_bin(tree:btree;x:tipokey;trovato:boolean;var ris:tipokey);
Procedure Insert_node(x:tipokey;var tree:btree);
Procedure Cerca_key(tree:btree;x:tipokey;var trovato:boolean;var ris:tipokey);
Procedure Del_t_fromkey (x:tipokey;var tree:btree;var trovato:boolean);
Procedure Stampa_antic2(tree:btree);
Procedure Randomint(var vet:permutaz);
Procedure Punta_key(tree:btree;x:tipokey; var node:btree);
Procedure Punta_key_bin(tree:btree;x:tipokey; var node:btree);
Procedure Cancellaxy (x,y:tipokey;var tree:btree);
Function x_ant_y (tree:btree;x,y:tipokey):boolean;
Procedure Conta_nodi(tree:btree;ris:integer);
Procedure Conta_nodi_bilanciati(tree:btree;var count:integer;var num:integer);
Function Isfoglia(tree:btree):boolean;
Procedure Autunno (var tree:btree);
Function Crea_radice(x:tipokey):btree;
Procedure Somma_ant (tree:btree;som:integer;x:tipokey;var ris:integer);
Procedure Cerca_max_ant (tree:btree;x:tipokey;maxtemp:tipokey;var maxant:tipokey);
Procedure Max_cammino (tree:btree;maxant:tipokey;var ok:boolean);
Procedure Sommax_in_order (tree:btree;x:tipokey;var som:integer);
Function Min_tree_bin (tree:btree):tipokey;
Function Max_tree_bin (tree:btree):tipokey;
Function Restituisci_min (var tree:btree):tipokey;
Procedure Cancella_x_bin (x:tipokey;var tree:btree);
Procedure Genera_da_vet (i,j:integer;var tree:btree;var A:permutaz);
Procedure Taglia_da_liv (n,liv:integer;var tree:btree);
Procedure Trasforma(tree:btree;var newt:btree);
Procedure Erode (var tree:btree);
Procedure Fatt_ram(tree:btree;var ram:integer);
Procedure Cancella_xy_AB (x,y:tipokey;var tree:btree);
Procedure Maxliv_x (Tree:btree; x:tipokey; liv:integer; var risult:integer);
Procedure Contorno (x:tipokey;var tree:btree);
Procedure Cerca_max_Antenato(x:tipokey;tree:btree;maxtemp:tipokey;var max:tipokey);
Procedure Gen_lista (tree:btree;var pippo:lista);
Procedure Angelo_Vendicatore (var tree:btree);
Procedure Fattoram(t:btree;var risult:integer);
Procedure Print_fromX (x:integer;bt:btree;var trovato:boolean);
Procedure ContaPerfetti(t:btree;var ris:integer;var somma:integer);
Procedure Perfect (bt:btree;var num:integer;oldbt:btree);
Procedure CercaMinMax(tree:btree;var Min,max:tipokey);
Procedure Canc_Liv_L (var T:btree;L,templiv:integer);
Function Genera_Alb_Bil(vet:permutaz;i,n:integer):btree;
Procedure FogliaMin(t:btree;var num:integer;tempmin:integer);
Procedure Pepetito (var t:btree);
Procedure PredSucc(t:btree;x:integer;var p,s:integer);
Function Somma_antenati(temp:integer;bt:btree):boolean;
Procedure Figghiu_meo(var bt:btree;x,y:integer);
Procedure XX(t:btree;var ris:integer;var P:boolean);


IMPLEMENTATION

{P=true, ris=0}
Procedure XX(t:btree;var ris:integer;var P:boolean);
var mioris:integer;
    figlio:btree;
begin
     if p=true then
                 begin
                   if t<>nil then
                               begin
                                 mioris:=0;
                                 figlio:=t^.left;
                                 while figlio<>nil do
                                                   begin
                                                     xx(figlio,mioris,P);
                                                     ris:=ris+mioris;
                                                     figlio:=figlio^.right;
                                                     mioris:=0;
                                                   end;
                                 if t^.key<=ris then P:=false;
                                 ris:=ris+t^.key;
                               end
                   else ris:=0;
                 end;
end;


{                               COMPITO DEL 7/9/98
1) Funzione che dato un albero binario bt controlla se in bt esiste almeno
una chiave uguale alla somma di tutti i suoi antenati propri, restituendo
true o false}
{temp=0}
Function Somma_antenati(temp:integer;bt:btree):boolean;
var tempris:boolean;
begin
     if bt<>nil then
                  begin
                    if bt^.key=temp then somma_antenati:=true
                       else
                         begin
                           temp:=temp+bt^.key;
                           tempris:=somma_antenati(temp,bt^.left);
                           if tempris=false then tempris:=somma_antenati(temp,bt^.right);
                           somma_antenati:=tempris;
                         end;
                  end
             else somma_antenati:=false;
end;

{2) Procedura che dato un albero binario bt della forma figlio-fratello
cerca ogni occorrenza di x nell'albero, una volta trovata controlla se
tra i figli di x ci sia y ed in caso negativo lo aggiunge}
{x<>y}
Procedure Figghiu_meo(var bt:btree;x,y:integer);
var figlio,frat:btree;
    esiste:boolean;
begin
     if bt<>nil then {l'albero non ä vuoto}
                  begin
                    if bt^.key=x then  {la radice ä = x}
                                   begin
                                     figlio:=bt^.left;
                                     esiste:=false;
                                     if figlio=nil then {la radice non ha figli}
                                                     begin {pone il figlio=y}
                                                       new(figlio);
                                                       figlio^.key:=y;
                                                       figlio^.right:=nil;
                                                       figlio^.left:=nil;
                                                       bt^.left:=figlio;
                                                     end
                                            else {la radice ha figli}
                                              begin
                                                while (figlio<>nil) do {scorri tutti i figli}
                                                           begin
                                                             if figlio^.key=y then esiste:=true;
                                                             frat:=figlio;
                                                             figlio:=figlio^.right;
                                                           end;
                                                if esiste=false then {se non ha trovato y ...}
                                                     begin {aggiungi}
                                                       new(figlio);
                                                       figlio^.key:=y;
                                                       figlio^.right:=nil;
                                                       figlio^.left:=nil;
                                                       frat^.right:=figlio;
                                                     end;
                                              end;
                                   end;
                    figlio:=bt^.left; {poi continua sui figli con lo stesso motivo}
                    while figlio<>nil do
                                      begin
                                        figghiu_meo(figlio,x,y);
                                        figlio:=figlio^.right;
                                      end;
                  end;
end;

{                               COMPITO 17/9/98
2) Procedura che dato una albero binario di ricerca T e una chiave x
restituisce in p e s rispettivamente il predecessore e il successore di x
se x occorre nell'albero. Se x non ha pred o succ p o s sono uguali a 0}
Procedure PredSucc(t:btree;x:integer;var p,s:integer);
var fig,temp:btree;
begin
     if t<>nil then
                 begin
                   if t^.key=x then
                                 begin
                                   if t^.left<>nil then
                                                     begin
                                                       fig:=t^.left^.right;
                                                       temp:=t^.left;
                                                       while fig<>nil do
                                                                        begin
                                                                          temp:=fig;
                                                                          fig:=fig^.right;
                                                                        end;
                                                       p:=temp^.key;
                                                     end
                                       else p:=0;
                                   if t^.right<>nil then
                                                     begin
                                                       fig:=t^.right^.left;
                                                       temp:=t^.right;
                                                       while fig<>nil do
                                                                        begin
                                                                          temp:=fig;
                                                                          fig:=fig^.left;
                                                                        end;
                                                       s:=temp^.key;
                                                     end
                                       else s:=0;
                                 end
                       else if t^.key>x then predsucc(t^.left,x,p,s)
                            else predsucc(t^.right,x,p,s);
                 end;
end;


{1)                              COMPITO DEL 21/1/99
Procedura che dato un albero binario della forma figlio-fratello t restituisce
in num il numero di chiavi minime in t, ovvero <= di tutti gli antenati propri
Num=0; tempmin=-1}
Procedure FogliaMin(t:btree;var num:integer;tempmin:integer);
var figlio:btree;
begin
     if t<>nil then
                 if (tempmin=-1) and (t^.left=nil) then num:=1
                    else
                      begin
                        if (tempmin=-1) and (t^.left<>nil) then tempmin:=t^.key;
                        if t^.key<=tempmin then begin
                                                  num:=num+1;
                                                  tempmin:=t^.key;
                                                end;
                        figlio:=t^.left;
                        while figlio<>nil do
                                          begin
                                            fogliamin(figlio,num,tempmin);
                                            figlio:=figlio^.right;
                                          end;
                      end;
end;

{2) Procedura che cancella da un albero binario t tutte le chiavi uguali
alla somma dei due figli, dove nil=0}
Procedure Pepetito (var t:btree);
var temp:integer;
begin
     if t<>nil then begin
                      temp:=0;
                      if t^.left<>nil then temp:=temp+t^.left^.key;
                      if t^.right<>nil then temp:=temp+t^.right^.key;
                      if t^.key=temp then t:=nil
                         else begin
                                pepetito(t^.left);
                                pepetito(t^.right);
                              end;
                    end;
end;

{                               COMPITO 10/2/99
1) Procedura che dato un albero binario t della forma figlio-fratello e dato
un intero L>0, modifica l'albero tagliando l'ultimo genito di ogni nodo
non foglia a partire dal livello L incluso.}
{Dati L>0 e Templiv=0}
Procedure Canc_Liv_L (var T:btree;L,templiv:integer);
var figlio:btree;

Function Notisfoglia(tt:btree):boolean;
begin
     if tt<>nil then
                if tt^.left<>nil then notisfoglia:=true
                   else notisfoglia:=false;
end;

Procedure DelUltimo (var TT:btree);
var temp,temp2:btree;
begin
     if tt^.left<>nil then
                      if tt^.left^.right=nil then tt^.left:=nil {figlio unico}
                                             else
                                               begin
                                                 temp2:=tt^.left^.right^.right;
                                                 temp:=tt^.left;
                                                 while temp2<>nil do
                                                                  begin
                                                                    temp2:=temp2^.right;
                                                                    temp:=temp^.right;
                                                                  end;
                                                 temp^.right:=nil;
                                               end;
end;

begin
     if t<>nil then
                 begin
                   figlio:=t^.left;
                   if templiv>=L-1 then if notisfoglia(T)=true then Delultimo(T);
                   while figlio<>nil do
                                     begin
                                       canc_liv_l (figlio,templiv+1,L);
                                       figlio:=figlio^.right;
                                     end;
                 end;
end;

{2) Genera un albero binario di ricerca bilanciato a partire da un vettore
ordinato in ordine decrescente}
Function Genera_Alb_Bil(vet:permutaz;i,n:integer):btree;
var temp:integer;node:btree;
begin
     if n>=i then   {c'ä almeno un elemento nel vettore}
               begin
                 temp:=(i+n) div 2;
                 new(node);
                 node^.key:=vet[temp];
                 node^.left:=genera_alb_bil(vet,temp+1,n);
                 node^.right:=genera_alb_bil(vet,i,temp-1);
                 genera_alb_bil:=node;
               end
       else genera_alb_bil:=nil;
end;

{                               COMPITO 23/6/98
 Procedura che dato un albero binario di ricerca t restituisce in min
il minimo di t e in max la massima chaive di t}
{T non ä vuoto!}
Procedure CercaMinMax(tree:btree;var min,max:tipokey);
Procedure Cercamin(tree:btree;var min:tipokey);
begin
     if tree^.left=nil then min:=tree^.key
        else cercamin(tree^.left,min);
end;
Procedure Cercamax(tree:btree;var max:tipokey);
begin
     if tree^.right=nil then max:=tree^.key
        else cercamax(tree^.right,max);
end;
begin
  cercamin(tree,min);
  cercamax(tree,max);
end;


{                               COMPITO 22/09/97
1) Procedura che conta il numero dei nodi perfetti in t albero binario di
ricerca. I nodi perfetti sono quelli che hanno etichetta = alla somma dei
nodi a loro minori. Si conviene che il minore dei nodi ä perfetto se ä
uguale a zero}
{dati ris e somma=0}
Procedure ContaPerfetti(t:btree;var ris:integer;var somma:integer);
begin
     if t<>nil then
                 begin
                   contaperfetti(t^.left,ris,somma);
                   if somma=t^.key then ris:=ris+1;
                   somma:=somma+t^.key;
                   contaperfetti(t^.right,ris,somma);
                 end;
end;

{soluzione quadratica-non ä efficiente}
{oldbt=bt, num=0}
Procedure Perfect (bt:btree;var num:integer;oldbt:btree);
{somma=0}
Procedure sommamin(bt:btree;var somma:integer;x:tipokey);
begin
     if bt<>nil then
                  begin
                    sommamin(bt^.left,somma,x);
                    if bt^.key<x then
                                   begin
                                     somma:=somma+bt^.key;
                                     sommamin(bt^.right,somma,x);
                                   end;
                  end;
end;
var tempris:integer;
begin
     if bt<>nil then
                  begin
                    perfect(bt^.left,num,oldbt);
                    tempris:=0;
                    sommamin(oldbt,tempris,bt^.key);
                    if tempris=bt^.key then num:=num+1;
                    perfect(bt^.right,num,oldbt);
                  end;
end;


{                               COMPITO 22/9/97
2) Vedi la procedura autunno}


{                               COMPITO 11/7/97
1)Procedura che dato un albero binario t della forma figlio-fratello ne
calcola il fattore di ramificazione}
{risult=0}
Procedure Fattoram(t:btree;var risult:integer);
var figli:btree;
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

{2)                             COMPITO 11/7/97
Procedura che dato un albero binario di ricerca bt stampa tutte e sole
le chiavi maggiori di x, se x appartiene all'albero, in ordine crescente}
{trovato=false}
Procedure Print_fromX (x:integer;bt:btree;var trovato:boolean);
begin
     if bt<>nil then
                  begin
                    print_fromx(x,bt^.left,trovato);
                    if bt^.key=x then trovato:=true;
                    if trovato=true then
                                    if bt^.key>x then write(bt^.key,' ');
                    print_fromx(x,bt^.right,trovato);
                  end;
end;

{                               COMPITO 5/9/97
1) Procedura che dato un albero binario T (figlio,fratello), cancella
il primogenito di ogni nodo con tutto il relativo sottoalbero e se la
radice ä una foglia restituisce l'albero vuoto}
Procedure Angelo_Vendicatore (var tree:btree);
var frat:btree;
begin
  if tree<>nil then {Albero vuoto}
                 begin
                   if tree^.left<>nil then {then tree:=tree^.right {sola radice o senza figli}
                        begin {Ha almeno il primogenito}
                          tree^.left:=tree^.left^.right;{steccola primogenito}
                          frat:=tree^.left;{pensa a suo fratello}
                          {se c'ä il fratello...}
                          while frat<>nil do {...e finchä ci sono fratelli}
                                           begin {fai lo stesso coi loro figli!}
                                             Angelo_vendicatore(frat);
                                             frat:=frat^.right;
                                           end;
                        end;  {nei secoli dei secoli!}
                   end;
end;

{1)                             COMPITO 5/2/98  - OK
Dato un albero binario Tree di interi distinti, dato x intero, restituisce
il pió grande fra gli antenati propri di x, se x occorre nell'albero e
non ä la radice, 0 altrimenti.}
{max=0, maxtemp=0}
Procedure Cerca_max_Antenato(x:tipokey;tree:btree;maxtemp:tipokey;var max:tipokey);
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
Procedure Gen_lista (tree:btree; var pippo:lista);
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
Procedure Maxliv_x (Tree:btree; x:tipokey; liv:integer; var risult:integer);
var temp:btree;
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
aggiunga x al posto di ogni nodo esterno. Se Bt ä vuot restituisce l'albero
con la sola chiave x}
Procedure Contorno (x:tipokey;var tree:btree);
var temp:btree;
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
cancella x se ä suo figlio}
Procedure Cancella_xy_AB (x,y:tipokey;var tree:btree);
var figlio,fratprec:btree;
begin
     if tree^.key=y then begin{la radice ä y}
        figlio:=tree^.left;
        fratprec:=nil;
        while figlio<>nil do begin
                          if figlio^.key=x then begin{figlio=x}
                             if fratprec=nil then {x ä il primo figlio di y}
                                if figlio^.right<>nil then tree^.left:=figlio^.right{controlla se ha fratelli a cui puntare}
                                   else figlio:=nil
                             else fratprec^.right:=figlio^.right;{x ä presente ma non come primogenito}
                             figlio:=figlio^.right;{continua la ricerca}
                             end{if}
                           else begin {figlio<>x}
                                fratprec:=figlio;
                                figlio:=figlio^.right;
                                end;
                           end;{if}
                          end{while}
        else begin {la radice t non ä = y}
             figlio:=tree^.left;
             while figlio<>nil do begin {cerca y tra i figli}
                   cancella_xy_AB(x,y,figlio);
                   figlio:=figlio^.right;
                   end;{while}
             end;{else}
end;

{Procedura che dato l'albero Ab binario, restituisce in ram il fattore di
ramificazione:max numero di figli di un nodo.In questo caso specifico
ä un dato superfluo}
{dato ram=0}
Procedure Fatt_ram(tree:btree;var ram:integer);
var figlio:btree;
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
Procedure Erode (var tree:btree);
var figlio,fratello:btree;
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
Procedure Trasforma(tree:btree;var newt:btree);
var radix:btree;
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
Procedure Taglia_da_liv (n,liv:integer;var tree:btree);
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
binario di ricerca il pió possibile bilanciato}
{dati i=1 e j=numdati}
Procedure Genera_da_vet (i,j:integer;var tree:btree;var A:permutaz);
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
Procedure Cancella_x_bin (x:tipokey;var tree:btree);
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
Function Restituisci_min (var tree:btree):tipokey;
begin
     if tree^.left=nil then begin
                            restituisci_min:=tree^.key;
                            tree:=tree^.right;
                            end
                       else restituisci_min:=restituisci_min(tree^.left);
end;

{come sotto}
Function Max_tree_bin (tree:btree):tipokey;
begin
     if tree=nil then max_tree_bin:=-1
        else begin
               if tree^.right=nil then max_tree_bin:=tree^.key
                                 else max_tree_bin:=max_tree_bin(tree^.right);
                               end;
end;

{FUnzione che dato un albero binario di ricerca restituisce il valore della
chiave minima, -1 se vuoto}
Function Min_tree_bin (tree:btree):tipokey;
begin
     if tree=nil then min_tree_bin:=-1
        else begin
               if tree^.left=nil then min_tree_bin:=tree^.key
                                 else min_tree_bin:=min_tree_bin(tree^.left);
                               end;
end;

{Procedura che dato T albero binario di ricerca, data una chive x restituisce
in som la somma di tutte le chiavi < di x, 0 altrimenti}
{dato som=0}
Procedure Sommax_in_order (tree:btree;x:tipokey;var som:integer);
begin
     if tree<>nil then begin
                       sommax_in_order(tree^.left,x,som);
                       if
                       tree^.key<x then begin
                                        som:=som+tree^.key;
                                        sommax_in_order(tree^.right,x,som);
                                        end;
                       end;
end;

{Procedura che dato un albero T controlla se ogni foglia ä massima nel
cammino dalla radice alla foglia}
{Dato maxant=0}
Procedure Max_cammino (tree:btree;maxant:tipokey;var ok:boolean);
begin
     if (tree<>nil) and (ok=true) then begin
                    if isfoglia(tree)=true then begin
                                                if tree^.key<maxant then ok:=false
                                                end
                       else begin
                            if tree^.key>maxant then maxant:=tree^.key;
                            Max_cammino(tree^.left,maxant,ok);
                            Max_cammino(tree^.right,maxant,ok);
                            end;
                     end;
end;

{Procedura che dato un albero T e una chiave x restituisce in ris il massimo
tra gli antenati di x, 0 altrimenti}
{Eventualmente aggiungere una variabile flag trovato}
{Dato maxtemp=0}
Procedure Cerca_max_ant (tree:btree;x:tipokey;maxtemp:tipokey;var maxant:tipokey);
begin
     if tree<>nil then begin
        if tree^.key=x then maxant:=maxtemp
                       else begin
                            if maxtemp<tree^.key then maxtemp:=tree^.key;
                            cerca_max_ant(tree^.left,x,maxtemp,maxant);
                            cerca_max_ant(tree^.right,x,maxtemp,maxant);
                            end;
                       end;
end;

{Procedura che dato una albero t e una chiave x restituisce la somma degli
antenati di x o 0 se la chiave non ä presente}
Procedure Somma_ant (tree:btree;som:integer;x:tipokey;var ris:integer);
begin
     if tree<>nil then begin
                  if tree^.key=x then ris:=som
                          else begin
                            som:=som+tree^.key;
                            somma_ant(tree^.left,som,x,ris);
                            somma_ant(tree^.right,som,x,ris);
                          end;
                       end;
end;

{Funzione che data una chiave x crea un albero di radice x e figli sin e des
uguali a nil}
Function Crea_radice(x:tipokey):btree;
var temp:btree;
begin
     new(temp);
     temp^.key:=x;
     temp^.left:=nil;
     temp^.right:=nil;
     crea_radice:=temp;
end;

{Procedura che dato ua albero T taglia tutte le foglie}
Procedure Autunno (var tree:btree);
begin
     if tree<>nil then begin
                       if isfoglia(tree)=true then tree:=nil
                          else begin
                               autunno(tree^.left);
                               autunno(tree^.right);
                               end;
                       end;
end;

{Funzione che prende in esame un albero e valuta se ä una foglia}
{tree<>nil}
Function Isfoglia(tree:btree):boolean;
begin
     if tree<>nil then
                  if (tree^.left=nil) and (tree^.right=nil) then isfoglia:=true
                                      else isfoglia:=false;
end;

{Procedura che dato un albero binario t restituisce il numero dei nodi bilanciati
dell'albero}
{dato count:=0}
Procedure Conta_nodi_bilanciati(tree:btree;var count:integer;var num:integer);
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
Procedure Conta_nodi(tree:btree;ris:integer);
begin
     if tree<>nil then begin
                  conta_nodi(tree^.left,ris);
                  ris:=ris+1;
                  conta_nodi(tree^.right,ris);
                  end;
end;

{Procedura che genera 10 numeri casuali da 0 a 20 incluso e la restituisce
in un vettore}
Procedure Randomint(var vet:permutaz);
var x,h:integer;
begin
     randomize;
     for x:=1 to numdati do vet[x]:=random(21);
end;


{Procedura che dati un certo numero di dati, restituisce una permutazione
casuale}
Procedure Shuffle (var vet:permutaz);
var temp,h,x:integer;
begin
     for x:=1 to numdati do vet[x]:=x;
     randomize;
     for x:=numdati downto 1 do begin
         h:=1+random(numdati-1);
         temp:=vet[h];
         vet[h]:=vet[x];
         vet[x]:=temp;
         end;
end;

{Procedura che dato un albero inserisce un nodo secondo le regole degli
alberi binari di ricerca}
Procedure Insert_node_bin(x:tipokey; var tree:btree);
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
Procedure STampa_tree_antic(tree:btree;rig,col:integer);
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

{Procedura che dato un albero restituisce il nodo di valore massimo o per
convenzione -1 se l'albero ä vuoto; si potrebbe migliorare considerando
che la ricerca comprende esclusivamente la radice e tutti i discendenti
destri della radice (perchä albero di ricerca)}
Procedure Cerca_max_bin(tree:btree;var max:tipokey);
var temp:tipokey;
begin
     if tree<>nil then begin
                       if tree^.key>max then max:=tree^.key;
                       {temp:=max;}
                       if tree^.left<>nil then cerca_max_bin(tree^.left,max);
                       {if max=-1 then max:=temp;
                       temp:=max; perchä eventualmente max ä cambiato}
                       if tree^.right<>nil then cerca_max_bin(tree^.right,max);
                       {if max=-1 then max:=temp;}
                       end
                  else max:=-1;

end;

{Procedura che dato un albero binario di ricerca esamina se ä presente la
chiave x: se ä presente la restituisce, altrimenti dÖ -1}
{ris=-1}
Procedure Cerca_key_bin(tree:btree;x:tipokey;trovato:boolean;var ris:tipokey);
begin
     if trovato=false then begin
             if tree<>nil then begin
                     if x=tree^.key then begin
                                          ris:=tree^.key;
                                          trovato:=true;
                                          end
                                    else begin
                                         if (x<tree^.key) and (tree^.left<>nil) then cerca_key_bin (tree^.left,x,trovato,ris)
                                              else if tree^.right<>nil then cerca_key_bin (tree^.right,x,trovato,ris);
                                         end
                           end {if}
                           else ris:=-1;
                     end; {if iniziale}
end;

{Procedura che data una certa chiave x restituisce un albero contenente
la chiave e non di ricerca. Non controlla se le chiavi sono distinte}
Procedure Insert_node (x:tipokey;var tree:btree);
var temp:btree;
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
la restituisce se la trova o -1 altrimenti.}
{trovato:=false}
Procedure Cerca_key (tree:btree;x:tipokey;var trovato:boolean;var ris:tipokey);
begin
  if trovato=false then begin
     if tree^.key=x then ris:=x
        else begin
        ris:=-1;
        if tree^.left<>nil then cerca_key(tree^.left,x,trovato,ris);
        if tree^.right<>nil then cerca_key(tree^.right,x,trovato,ris);
        end; {if}
     if (ris>=0) then trovato:=true;
  end;{if}
end;

{Procedura che dato un albero T e una chiave x, se la chiave ä presente
nell'albero,  cancella il primo sottoalbero di radice x}
Procedure Del_t_fromkey (x:tipokey;var tree:btree;var trovato:boolean);
var temp:btree;
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

Procedure Stampa_antic2 (tree:btree);
var figlio:btree;
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
Procedure Punta_key(tree:btree;x:tipokey; var node:btree);
begin
     if tree<>nil then begin
        if tree^.key=x then node:=tree
           else begin
                punta_key(tree^.left,x,node);
                punta_key(tree^.right,x,node);
                end;
     end;
end;

{COme punta_key solo che ä applicata ad un albero binario di ricerca e
dunque ä ottimizzata}
{node:=nil}
Procedure Punta_key_bin(tree:btree;x:tipokey; var node:btree);
begin
     if tree<>nil then begin
        if tree^.key=x then node:=tree
           else if tree^.key<x then punta_key_bin(tree^.right,x,node)
                   else punta_key_bin(tree^.left,x,node);
     end;
end;

{Procedura che dato un albero t cerca la chiave x, se x ä presente in T
allora verifica che il figlio sinistro e destro di x siano = a y e in
tal caso li cancella}
{dati x e y}
Procedure Cancellaxy (x,y:tipokey;var tree:btree);
var pippo:btree;
begin
     pippo:=nil;
     punta_key(tree,x,pippo);
     if pippo<>nil then begin
        if pippo^.left^.key=y then pippo^.left:=nil;
        if pippo^.right^.key=y then pippo^.right:=nil;
     end;
end;

{FUnzione che dato T albero, se non ä vuoto restituisce true se x ä antenato
di y e false altrimenti}
{dati x e y}
Function x_ant_y (tree:btree;x,y:tipokey):boolean;
var pippo:btree;
    trovato:boolean;
    ris:integer;
begin
     if tree<>nil then begin
                  pippo:=nil;
                  punta_key(tree,x,pippo);
                  if pippo<>nil then begin
                                trovato:=false;
                                cerca_key(pippo,y,trovato,ris);
                                x_ant_y:=trovato;
                                end;
                  end;
end;



end. {UNIT}
