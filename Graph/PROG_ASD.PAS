
Program Confronto_Grafi (input,output);
uses crt, dos;
const maxV = 100; {Numero massimo di vertici}
      Tot_archi = ((maxV+1) * maxV) div 2;  {numero totale di archi calcolato
                                             in base al numero di vertivi con
                                             la formula di Gauss}

type coppiaV=record
                V1,V2:byte;
             end;

    link=^node;
    node=record
             v: byte;
             next: link
          end;

    vettore_liste=array[1..maxV] of link;
    vett_archi = array[1..Tot_archi] of coppiaV;
    mat_grafo =array [1..maxV,1..maxV] of boolean;
var
    V,E : integer; {rispettivamente Num. Vertici e Num. Archi}
    adj : vettore_liste; {lista di adiacenza}
    archi : vett_archi; {vett. contenente le coppie di vertici congiunti
                         da un arco}
    x:integer;
    a:mat_grafo;

{------------------------------------------------}

{Stampa_matrice______________________________________________________________}
Procedure Stampa_matrice(a:mat_grafo);
var int1, int2:integer;
    key:char;
    x,y,temp1,temp2:integer;
    riga:integer;

    function rileggi(ris:boolean):integer;
    begin
      if ris=true then
           rileggi:=1
      else
          rileggi:=0;
    end;

begin
     clrscr;
     int1:=1; int2:=1;
     textcolor(15);
     textbackground(1);
     gotoxy(10,25);
     write('Usare i tasti freccia per scorrere la matrice - Invio per proseguire');
     textcolor(15);
     textbackground(0);
     repeat
        riga:=2;
        temp1:=int1+20;
        if temp1>V then temp1:=V;
        temp2:=int2+20;
        textcolor(10);
        gotoxy(4,1);
        if temp2>V then temp2:=V;
        for x:=int2 to temp2 do
                             begin
                                  if x>9 then write(x,' ')
                                     else write(x,'  ');
                             end;
        writeln;
        for y:=int1 to temp1 do
                              writeln(y,' ');
        for x:=int1 to temp1 do
            begin
               gotoxy(4,riga);
               for y:=int2 to temp2 do
                           begin
                             if rileggi(a[x,y])=1 then textcolor(12)
                                else textcolor (15);
                             write(rileggi(a[x,y]),'  ');
                           end;
               writeln;
               riga:=riga+1;
            end;
        key:=readkey;
        if key=chr(72) then
                         begin
                           if int1>1 then int1:=int1-1
                              else
                                  begin
                                     gotoxy(68,23);
                                     textcolor(14);
                                     write ('Fine Matrice');
                                     textcolor (15);
                                    readkey;
                                  end;
                         end
           else if key=chr(80) then
                         begin
                           if int1<v then int1:=int1+1
                              else
                                  begin
                                     gotoxy(68,23);
                                     textcolor(14);
                                     write ('Fine Matrice');
                                     textcolor (15);
                                     readkey;
                                  end;
                         end
                else if key=chr(75) then
                         begin
                           if int2>1 then int2:=int2-1
                              else
                                  begin
                                     gotoxy(68,23);
                                     textcolor(14);
                                     write ('Fine Matrice');
                                     textcolor (15);
                                    readkey;
                                  end;
                         end
                    else if key=chr(77) then
                         begin
                           if int2<v then int2:=int2+1
                              else begin
                                     gotoxy(68,23);
                                     textcolor(14);
                                     write ('Fine Matrice');
                                     textcolor (15);
                                     readkey;
                                   end;
                         end;
        clrscr;
     until  key=char(13)
end;

{crea_archi__________________________________________________________________}
procedure crea_archi(V, E : integer; var archi : vett_archi);
var
   cont,j,i:integer;
   risp : char;


    procedure shuffle (var a : vett_archi; c : integer);
    var
       i, r : integer;
       temp : coppiaV;
    begin
          randomize;
          for i := c downto 2 do
          begin
               r := random(i) + 1;
               temp := a[i];
               a[i] := a[r];
               a[r] := temp;
          end;
    end;


begin
    cont:=1;
    for i:=1 to V do
        for j:=1 to i do
            begin
                 archi[cont].v1:=j;
                 archi[cont].v2:=i;
                 cont:=cont+1;
            end;
    shuffle(archi, cont-1);
    writeln ('Vuoi vedere gli archi creati ? (y/n)');
    repeat
          risp := readkey;
    until risp in ['y','Y','n','N'];
    if (risp='y') or (risp='Y') then
    begin
        writeln('Vettore archi creato : ');
        for i:=1 to E do
        begin
           write (archi[i].V1:3,'->',archi[i].V2 :3);
           textcolor(2);
           write(' *');
           textcolor(15);
           if (i mod 168) = 0 then
              readln;

        end;
        readln;
    end;
end;


{crea_matrice_grafo__________________________________________________________}
{procedura che crea la matrice di adiacenza}
procedure crea_matrice_grafo (V, E : integer);
var j,x,y: integer;
begin
     for x:=1 to V do
         for y:=1 to V do
             a[x,y]:=false;
     for j:=1 to E do
     begin
          x:=archi[j].v1;
          y:=archi[j].v2;
          a[x,y]:=true;
          a[y,x]:=true
     end;
end;

{crea_lista_grafo____________________________________________________________}
{procedura che crea il vettore di liste di adiacenza}
procedure crea_lista_grafo (V, E : integer);
var j,x,y: integer;
    t: link;
begin
  for j:=1 to V do
      adj[j]:=nil;
  for j:=1 to E do
  begin
    x:=archi[j].v1;
    y:=archi[j].v2;
    new(t);
    t^.v:=x;
    t^.next:=adj[y];
    adj[y]:=t;
    if x<>y then
    begin
         new(t);
         t^.v:=y;
         t^.next:=adj[x];
         adj[x]:=t;
    end;
  end;
end;

{Stampa_lista_grafo__________________________________________________________}
{procedura che visualizza il vettore di liste di adiacenza}
procedure Stampa_lista_grafo (adj:vettore_liste);
var
    x, c1, linee : integer;
    t : link;
begin
     clrscr;
     textcolor(14);
     gotoxy(23,1);
     writeln('QUESTA E'' LA LISTA DI ADIACENZA');
     textcolor(15);
     linee := 0;
     for x:=1 to V do
     begin
          c1:=0;
          t:=adj[x];
          textcolor(11);
          write (x,'->');
          textcolor(15);
          while t<>nil do
          begin
               c1 := c1 + 1;
               write(t^.v,'->');
               if c1 = 18 then
               begin
                    c1 := 0;
                    writeln;
                    linee := linee+1;
                    if (linee mod 23 = 0) then
                       readln;
               end;
               t:=t^.next;
          end;
          writeln;
          linee := linee + 1;
          if (linee mod 23 = 0) then
                readln;
          writeln;
          linee := linee + 1;
          if (linee mod 23 = 0) then
                readln;
       end;
    readln;
end;

{visita_lista________________________________________________________________}
{procedure che effettua la visita nel vettore di liste, contando il numero di
operazioni effettuate}
procedure visita_lista;
var
    id, k, op : integer;
    val : array[1..maxV] of integer;

  procedure visit(k: integer);
    var
       t : link;
  begin
    id:=id+1;
    val[k]:=id;
    t := adj[k];
    write (k,'->');
    while t<>nil do
    begin
      op := op+1;
      if val[t^.v]=0 then
         visit(t^.v);
      t:=t^.next
    end
  end;

begin
  clrscr;
  textcolor(14);
  gotoxy(30,1);
  write('VISITA LISTA : ');
  TEXTCOLOR(15);
  writeln;
  writeln;
  id := 0;
  op := 0;
  for k:=1 to V do
      val[k]:=0;
  for k:=1 to V do
  begin
    op := op+1;
    if val[k]=0 then
    begin
         visit(k);
         if (k mod 23=0) then
            readln;
         writeln ;
    end;
  end;
  textcolor(14);
  writeln;
  writeln;
  writeln ('Operazioni : ',op);
  writeln ('Invio per tornare al menu ....  ');
  textcolor(15);
  readln;
end;

{visita_matrice______________________________________________________________}
{procedura che effettua la visita nella matrice di adiacenza, contando il
numero di operazioni effettuate}
procedure visita_matrice;
var id,k,op: integer;
    val: array[1..maxV] of integer;

  procedure visit(k: integer);
  var t: integer;
  begin
  id:=id+1;
  val[k]:=id;
  write (k,'->');
  for t:=1 to V do
  begin
       op := op+1;
       if a[k,t] then
       if val[t]=0 then
          visit(t);
  end;
  end;

begin
  clrscr;
  gotoxy(30,1);
  textcolor(14);
  writeln ('VISITA MATRICE : ');
  textcolor(15);
  writeln;
  id:=0;
  op := 0;
  for k:=1 to V do val[k]:=0;
  for k:=1 to V do
  begin
    op := op+1;
    if val[k]=0 then
    begin
         visit(k);
         if (k mod 23=0) then readln;
         writeln ;
    end;
  end;
  textcolor(14);
  writeln;
  writeln;
  writeln ('Operazioni : ',op);
  writeln ('Invio per visitare la lista ....  ');
  textcolor(15);
  readln;
end;

{Intestazione________________________________________________________________}
Procedure intestazione;
begin
    {intestazione}
       textcolor(14);
       textbackground (2);
       gotoxy(55,2);
       writeln('                        ');
       gotoxy(55,3);
       writeln('                        ');
       gotoxy(55,4);
       writeln('                        ');
       gotoxy(55,5);
       writeln('                        ');
       gotoxy(55,6);
       writeln('                        ');
       gotoxy(55,7);
       writeln('                        ');
       gotoxy(55,8);
       writeln('                        ');

       gotoxy(58,3);
       textcolor(15);
       write('PROGETTO: A.S.D. II');
       textcolor(14+blink);
       gotoxy(61,5);
       write('Visita Grafi');
       textcolor(15);
       gotoxy(57,7);
       write('Anno Accademico 99/00');
end;

{procedure crea_grafo _______________________________________________________}
procedure crea_grafo (var E,V:integer; var archi:vett_archi);
var
   max_arch : integer;
begin
       clrscr;
       gotoxy(1,5);
       textcolor(14);
       textbackground (9);
       writeln('                                                  ');
       writeln('                                                  ');
       writeln('                                                  ');
       gotoxy(1,6);
       textbackground (11);
       writeln('                                                  ');
       repeat
         gotoxy(1,6);
         write('Inserisci il numero di vertici :     ');
         gotoxy (34,6);
         readln (V);
       until v in [0..100];
       gotoxy(1,9);
       textbackground (9);
       writeln('                                                  ');
       writeln('                                                  ');
       writeln('                                                  ');
       gotoxy(1,10);
       textbackground (11);
       writeln('                                                  ');
       gotoxy(1,10);
       write ('Inserisci il numero di archi : ');
       repeat
         gotoxy(32,10);
         write('            ');
         gotoxy(32,10);
         readln(E);
         max_arch := ((V+1)*V) div 2;
         if max_arch<E then
                     begin
                       gotoxy(30,15);
                       textbackground(4);
                       writeln('Numero archi non valido!');
                       readln;
                       textbackground(0);
                       gotoxy(20,15);
                       write('                                    ');
                       textbackground(11);
                     end;
       until (max_arch>=E) and (E>0);
       textbackground(8);
       clrscr;
       textcolor (15);
       crea_archi (V, E, archi);
       crea_matrice_grafo (V, E);
       crea_lista_grafo(V, E);
end;

{menu________________________________________________________________________}
procedure menu;
var
   scelta:char;
   grafo_creato : boolean;

procedure errore;
begin
  clrscr;
  gotoxy(18,5);
  textbackground(4);
  textcolor(15+blink);
  write('Errore : Devi prima creare un nuovo grafo ');
  textbackground(0);
  textcolor(15);
  readln;
end;

begin
     grafo_creato := false;
     repeat
        intestazione;
        textbackground(12);
        gotoxy (3,2);
        write (' 1 ');
        gotoxy (3,4);
        write (' 2 ');
        gotoxy (3,6);
        write (' 3 ');
        gotoxy (3,8);
        write (' 4 ');
        gotoxy (3,12);
        write (' 5 ');
        textbackground(0);
        textcolor(15);
        gotoxy (7,2);
        write('CREA GRAFO');
        gotoxy (7,4);
        write('VISITA GRAFO');
        gotoxy (7,6);
        write('VISUALIZZA MATRICE GRAFO');
        gotoxy (7,8);
        write('VISUALIZZA LISTA GRAFO');
        gotoxy (7,12);
        write('ESCI');
        scelta:=readkey;
        case scelta of
        '1': begin
                  crea_grafo(E,V,Archi);
                  grafo_creato := true;
             end;
        '2': begin
               if not grafo_creato then errore
               else begin
                     visita_matrice;
                     visita_lista;
               end;
             end;
        '3': if not(grafo_creato) then errore
                     else Stampa_matrice (a);

        '4': if not(grafo_creato) then errore
                 else Stampa_lista_grafo(adj);
        end;

        clrscr;
     until scelta='5';
end;


{MAIN************************************************************************}
Begin
       clrscr;
       menu;
end.{MAIN}
