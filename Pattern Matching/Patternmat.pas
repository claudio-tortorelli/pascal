program progetto;
uses crt;
const max_dim_pattern=50;
type indexarray=array[1..max_dim_pattern] of integer;
     alphabetarray=array[char] of integer;
var i,n,m,comp_ban,compKMP1,compKMP2,comp_bm2:integer;
    riga1,riga2,riga3,riga4:string;
    testo,pattern:string;
    fail,delta1:indexarray;
    delta:alphabetarray;
    match:boolean;
    scelta:byte;
    
procedure algoritmo_banale(t,p:string;var comp:integer;var match:boolean);
var i,j,k:integer;
begin
  i:=1;
  j:=1;
  k:=1;
  while (j<=n) and (k<=m) do
    begin
      comp:=comp+1;
      if t[j]=p[k] then begin j:=j+1; k:=k+1; end
        else begin i:=i+1; j:=i; k:=1; end;
    end;
  if k>m then match:=true;
end;
  
procedure kmpsetup(p:string;var f:indexarray;var comp:integer);
var k,r:integer;
begin
  f[1]:=0;
  r:=0;
  for k:=2 to m do
    begin
      while (r>0) and (p[r]<>p[k-1]) do begin
        r:=f[r];
        comp:=comp+1;
        end;
      comp:=comp+1;
      r:=r+1;
      if p[k]=p[r] then f[k]:=f[r]
        else f[k]:=r;
      comp:=comp+1;
    end;
end;

procedure kmp(t,p:string;fail:indexarray;var comp:integer);
var j,k:integer;
begin
  j:=1;
  k:=1;
  while (j<=n) and (k<=m) do
    begin
      if (k=0) or (t[j]=p[k]) then
        begin
          j:=j+1;
          k:=k+1;
        end
      else k:=fail[k];
      comp:=comp+1;
    end;
end;

procedure computedeltajumps(p:string;var delta:alphabetarray);
var k:integer;
begin
  delta['''']:=m;
  delta[' ']:=m; delta['.']:=m;
  delta['a']:=m; delta['A']:=m;
  delta['b']:=m; delta['B']:=m;
  delta['c']:=m; delta['C']:=m;
  delta['d']:=m; delta['D']:=m;
  delta['e']:=m; delta['E']:=m;
  delta['f']:=m; delta['F']:=m;
  delta['g']:=m; delta['G']:=m;
  delta['h']:=m; delta['H']:=m;
  delta['i']:=m; delta['I']:=m;
  delta['j']:=m; delta['J']:=m;
  delta['k']:=m; delta['K']:=m;
  delta['l']:=m; delta['L']:=m;
  delta['m']:=m; delta['M']:=m;
  delta['n']:=m; delta['N']:=m;
  delta['o']:=m; delta['O']:=m;
  delta['p']:=m; delta['P']:=m;
  delta['q']:=m; delta['Q']:=m;
  delta['r']:=m; delta['R']:=m;
  delta['s']:=m; delta['S']:=m;
  delta['t']:=m; delta['T']:=m;
  delta['u']:=m; delta['U']:=m;
  delta['v']:=m; delta['V']:=m;
  delta['w']:=m; delta['W']:=m;
  delta['x']:=m; delta['X']:=m;
  delta['y']:=m; delta['Y']:=m;
  delta['z']:=m; delta['Z']:=m;
  delta['0']:=m; delta['1']:=m;
  delta['2']:=m; delta['3']:=m;
  delta['4']:=m; delta['5']:=m;
  delta['6']:=m; delta['7']:=m;
  delta['8']:=m; delta['9']:=m;
  for k:=1 to m do delta[p[k]]:=(m-k);
end;

procedure computedelta1jumps(p:string;var delta1:indexarray);
var k,q,qq:integer;
    back:indexarray;
begin
  for k:=1 to m do delta1[k]:=(2*m-k);
  k:=m;
  q:=m+1;
  while k>0 do
    begin
      back[k]:=q;
      while (q<=m) and (p[q]<>p[k]) do
        begin
          if (m-k)<delta1[q] then delta1[q]:=(m-k);
          q:=back[q];
        end;
      k:=k-1;
      q:=q-1;
    end;
    for k:=1 to q do if (m+q-k)<delta1[k] then delta1[k]:=(m+q-k);
    qq:=back[q];
    while q<=m do
      begin
        while q<=qq do
          begin
            if (qq-q+m)<delta1[q] then delta1[q]:=(qq-q+m);
            q:=q+1;
          end;
        qq:=back[qq];
      end;
end;

procedure BM2(t,p:string;delta:alphabetarray;delta1:indexarray;var comp:integer);
var j,k,temp:integer;
begin
  j:=m;
  k:=m;
  while (j<=n) and (k>0) do
    begin
      comp:=comp+1;
      if t[j]=p[k] then
        begin
          j:=j-1;
          k:=k-1
        end
      else
        begin
          if delta[t[j]]<delta1[k] then temp:=delta1[k]
            else temp:=delta[t[j]];
          j:=j+temp;
          k:=m
        end;
      if k=0 then match:=true;
    end;
end;

procedure cerca;
begin
  n:=length(testo);
  write('Inserisci il pattern: ');
  read(pattern);
  m:=length(pattern);
  writeln('Lunghezza del testo: ',n);
  writeln('Lunghezza del pattern: ',m);
  writeln;
  comp_ban:=0;
  match:=false;
  algoritmo_banale(testo,pattern,comp_ban,match);
  if match=true then writeln('Il pattern e'' presente nel testo')
    else writeln('Il pattern non e'' presente nel testo');
  writeln;
  writeln('Algoritmo banale:                          ',comp_ban,' confronti');
  compKMP1:=0;
  kmpsetup(pattern,fail,compKMP1);
  compKMP2:=0;
  kmp(testo,pattern,fail,compKMP2);
  writeln('Algoritmo KMP:                             ',compkmp1,' + ',compkmp2,' = ',compkmp1+compkmp2,' confronti');
  computedeltajumps(pattern,delta);
  comp_bm2:=0;
  computedelta1jumps(pattern,delta1);
  bm2(testo,pattern,delta,delta1,comp_bm2);
  writeln('Algoritmo Boyer Moore (seconda euristica): ',comp_bm2,' confronti');
  readkey;
end;

begin
  repeat
        clrscr;
        writeln('1) Periodo di un libro');
        writeln('2) Scioglilingua');
        writeln('3) Stringa binaria');
        writeln('0) Esci');
        writeln;
        write('Scegli un testo su cui effettuare la ricerca: ');
        readln(scelta);
        case scelta of
                1: begin
                        clrscr;
                        writeln('Il testo su cui effettuare la ricerca e'' il seguente:');
                        writeln;
                        riga1:='Il pipelining e'' una tecnica di realizzazione in cui si sovrappone ';
                        riga2:='l''esecuzione di piu'' istruzioni; una pipeline e'' come una catena ';
                        riga3:='di montaggio: in entrambe ciascun passo completa una parte del ';
                        riga4:='lavoro complessivo.';
                        writeln(riga1);
                        writeln(riga2);
                        writeln(riga3);
                        writeln(riga4);
                        writeln;
                        testo:=riga1+riga2+riga3+riga4;
                        cerca;
                        end;
                2: begin
                        clrscr;
                        writeln('Il testo su cui effettuare la ricerca e'' il seguente:');
                        writeln;
                        testo:='Trentatre'' trentini entrarono in Trento tutti e trentatre'' trotterellando';
                        writeln(testo);
                        writeln;
                        cerca;
                        end;
                3:begin
                        clrscr;
                        writeln('Il testo su cui effettuare la ricerca e'' il seguente:');
                        writeln;
                        testo:='010000000011101010000000101111010111';
                        writeln(testo);
                        writeln;
                        cerca;
                        end;
        end;
  until scelta=0;
end.
