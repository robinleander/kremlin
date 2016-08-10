module Hoisting

open FStar.Int32

assume val krml_print: Int32.t -> ML unit
assume val ignore: unit -> ML unit

let test () =
  ignore ();
  let z = 0l in
  let x =
    let y =
      let b1 = true in
      let b2 = true in
      b1 || b2
    in
    let a = 0l in
    krml_print a;
    let b = 0l in
    if let z = true in z = y then begin
      ignore ();
      let a = 1l in
      ignore ();
      krml_print (a +^ b);
      a +^ b
    end else begin
      ignore ();
      let b = 2l in
      ignore ();
      krml_print (a -^ b);
      a -^ b
    end
  in
  let y = 0l in
  krml_print (x +^ y +^ z);
  x

let test' (): Int32.t =
  let x = true in
  if x = false then
    ()
  else begin
    let x = 0l in
    let y =  x +^ 0l in
    krml_print y
  end;
  1l
