Program sedlo;
Const 
  SIZE = 50;
Var
  s : array [1..SIZE, 1..2] of integer;
  symbol : char;
  io : text;
  x, y, count, m, n, a, b, minimum, maximum, columns, i, j, err : integer;
  buf : array [1..SIZE] of string;
  matrix : array [1..SIZE, 1..SIZE] of integer;
  input : string;
  Keys : set of char;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }  
procedure Error(num : integer);
begin
  case num of 
    1 : writeln('Fatal Error(' + num + '): Ошибка выбора ввода данных в программу.');
    2 : writeln('Fatal Error(' + num + '): Ошибка открытия файла.');
    3 : writeln('Fatal Error(' + num + '): Ввод данных для этой задачи '
                + 'осуществляется только с файла. См. описание (-h)'
                );
  end;
  halt();
  readln();
end;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
function isDigit(symbol : char) : boolean;
begin
  if (symbol <= '9') and (symbol >= '0') then
    isDigit := TRUE
  else
    isDigit := FALSE;
end;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  
Begin
   if ParamCount <> 0 then
  begin
    for i := 1 to ParamCount do
      if ParamStr(i)[1] = '-' then
        Keys := Keys + [ParamStr(i)[2]];
  end;
  if (('e' in Keys) and ('r' in Keys)) or (('e' in Keys) and ('f' in Keys)) or (('r' in Keys) and ('f' in Keys)) then
    Error(1)
  else
  begin
    if 'h' in Keys then
      writeln('В файле задан массив a[1..n, 1..m]. Некоторый элемент '
              + 'массива называется седловой точкой, если он является '
              + 'одновременно наименьшим в своей строке и наиболь'
              + 'шим в своем столбце. Вывести № строки и столбца всех '
              + 'седловых точек заданной матрицы. Если седловые точ'
              + 'ки отсутствуют, вывести соответствующее сообщение.'
               );
    if 'i' in Keys then
      writeln('Музыкантов Никита');
    if 'g' in Keys then
      writeln('М8О-111Б');
    if ('r' in Keys) or ('e' in Keys) then
      Error(3) 
    else if NOT fileexists(ParamStr(ParamCount)) then
      Error(2)
    else
      begin
        Assign(io, ParamStr(ParamCount));
        Reset(io);
        i := 1;
        j := 1;
        columns := 0;
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
{*                        Инициализация матрицы                               *}
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
        while NOT Eof(io) do
          begin
            while NOT Eoln(io) do
              begin
                read(io, symbol);
                input := input + symbol;
              end;
            while length(input) <> 0 do
              begin
                symbol := input[1];
                if isDigit(symbol) then
                  buf[j] := buf[j] + symbol
                else if symbol = ' ' then
                  begin
                    val(buf[j], matrix[i][j], err);
                    inc(j);
                  end;
                delete(input, 1, 1);
                if length(input) = 0 then
                  val(buf[j], matrix[i][j], err);
              end;
            for j := 1 to j do
                  buf[j] := '';
            inc(i);
            columns := j;
            j := 1;
            readln(io);
          end;
        dec(i);
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
        count := 0;
        for m := 1 to i do
          begin
            for n := 1 to columns do
              begin
                minimum := matrix[m][n];
                maximum := matrix[m][n];
                for a := 1 to i do
                  if matrix[m][a] < minimum then
                    minimum := matrix[m][a];
                for b := 1 to columns do
                  begin
                    if matrix[b][n] > maximum then
                      maximum := matrix[b][n];
                  end;
                if (minimum = matrix[m][n]) AND (maximum = matrix[m][n]) then
                  begin
                    inc(count);
                    s[count][1] := m;
                    s[count][2] := n;
                  end;
              end;
          end;
          if s[1][1] = 0 then
            writeln('Нет седловых точек')
          else  
            for i := 1 to count do
              begin
                for j := 1 to 2 do
                  write(s[i][j], ' ');
                writeln;
              end;
      end;
  end;
End.