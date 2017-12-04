program roflanebalo;
uses crt;
type
  node_t = ^node;                       // Template of queue structure
  node = record
    data : longint;
    next : node_t;
    end;
var
  head : node_t;
  N : longint;
  err : byte;
  input : string;

procedure Error(num : byte);
begin
  case num of
  1 : writeln('Invalid value.');
  end;
end;
procedure scanf(var N : longint);
var
  s : string;
  temp : longint;
  err : byte;
begin
  readln(s);
  val(s, temp, err);
  if (err > 0) OR (temp < 0) then
    begin
      Error(1);
      write('Enter a correct number: ');
      scanf(N);
    end
  else N := temp;
end;

procedure push(var N : longint);    // Adding data to the begin of queue
var
  x : node_t;
begin
  new(x);
  if (head = nil) then              // If queue is empty
    begin
      x^.data := N;
      x^.next := nil;
      head := x;
    end
  else
    begin
      x^.data := N;
      x^.next := head;
      head := x;
    end;
end;

procedure del();                    // Removing the last element in queue
var
  x, prev_x : node_t;
begin
  x := head;
  prev_x := head;
  while x^.next <> nil do
    begin
      prev_x := x;
      x := x^.next;
    end;
  prev_x^.next := nil;
  if x^.data mod 2 = 0 then writeln('Deleting an unique number: ', x^.data);
  dispose(x);
end;

procedure print_list();
var
  x : node_t;
begin
  write('Queue contains now: ');
  x := head;
  while x <> nil do
    begin
      write(x^.data, ' ');
      x := x^.next;
    end;
  writeln;
end;


begin
  write('Enter the number to push it into queue(0 - end of queue): ');
  scanf(N);
  while (N <> 0) do
    begin
      push(N);
      print_list();
      write('Enter the number to push it into queue: ');
      scanf(N);
    end;
  if head = nil then
    begin
      writeln('An empty queue');
      readln;
      halt;
    end;
  write('Starting to delete numbers');
  delay(500);
  write('.');
  delay(500);
  write('.');
  delay(500);
  writeln('.');
  while head^.next <> nil do
    begin
      print_list();
      del();
    end;
  print_list();
  del();
  write('Program exited with code 0. Press any key.');
  readln
end.
