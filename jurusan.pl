% SISTEM PEMILIHAN JURUSAN TEKNIK
% DATABASE
:- dynamic preferensi_pos/1.
:- dynamic preferensi_neg/1.

% PERTANYAAN MINAT
pertanyaan(suka_matematika) :- write("Apakah Anda suka Matematika?").
pertanyaan(suka_menggambar) :- write("Apakah Anda suka menggambar atau desain?").
pertanyaan(suka_komputer) :- write("Apakah Anda suka komputer dan pemrograman?").
pertanyaan(suka_lapangan) :- write("Apakah Anda suka bekerja di lapangan atau eksplorasi?").
pertanyaan(suka_mekanik) :- write("Apakah Anda suka mesin atau sistem mekanik?").
pertanyaan(suka_konstruksi) :- write("Apakah Anda tertarik pada pembangunan atau konstruksi bangunan?").
pertanyaan(suka_listrik) :- write("Apakah Anda suka kelistrikan dan rangkaian elektronik?").
pertanyaan(suka_analisis) :- write("Apakah Anda suka menganalisis sistem dan proses industri?").

% DIAGNOSA PREFERENSI
diagnosa(G) :-
    pertanyaan(G),
    writeln(" (y/t)"),
    read(Jawaban),
    Jawaban == y,
    assertz(preferensi_pos(G)).
diagnosa(G) :-
    assertz(preferensi_neg(G)),
    fail.

% CEK PREFERENSI
preferensi(G) :- preferensi_pos(G), !.
preferensi(G) :- preferensi_neg(G), !, fail.
preferensi(G) :- diagnosa(G).

% SARAN JURUSAN
jurusan(teknik_informatika) :-
    preferensi(suka_komputer),
    preferensi(suka_matematika),
    writeln("Jurusan yang cocok: Teknik Informatika").

jurusan(teknik_geologi) :-
    preferensi(suka_lapangan),
    preferensi(suka_menggambar),
    writeln("Jurusan yang cocok: Teknik Geologi").

jurusan(teknik_industri) :-
    preferensi(suka_analisis),
    preferensi(suka_matematika),
    writeln("Jurusan yang cocok: Teknik Industri").

jurusan(teknik_sipil) :-
    preferensi(suka_konstruksi),
    preferensi(suka_menggambar),
    writeln("Jurusan yang cocok: Teknik Sipil").

jurusan(teknik_elektro) :-
    preferensi(suka_listrik),
    preferensi(suka_matematika),
    writeln("Jurusan yang cocok: Teknik Elektro").

jurusan(_) :-
    writeln("Belum dapat menentukan jurusan yang cocok.").

% CLEAR DATABASE
clear_db :-
    retractall(preferensi_pos(_)),
    retractall(preferensi_neg(_)).

% MAIN LOOP
main :-
    write('\33\[2J'), % Clear screen
    writeln("SISTEM SARAN PEMILIHAN JURUSAN TEKNIK"),
    jurusan(_),
    clear_db,
    writeln("INGIN MENGULANG? (y/t)"),
    read(Jawaban), !,
    Jawaban == y,
    main.