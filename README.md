# SoalShift_modul2_C12
1. 18-0034 Rofita Siti Musdalifah
2. 18-0086 Calvin Wijaya
#
1. [Soal1](#soal1)
2. [Soal2](#soal2)
3. [Soal3](#soal3)
#

# Soal1
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file "​Sample-Superstore.tsv​". Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :<br>
a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit<br>
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a <br>
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b<br> Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan laporan tersebut.  *Gunakan Awk dan Command pendukung
#
## Jawab
a. Menentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit<br>
   Langkah pertama kita harus mengolah data pada file "Sample-Superstore.tsv" terlebih dahulu untuk mendapatkan keuntungan di tiap region, kemudian kita bandingkan mana yang memiliki keuntungan paling rendah. Berikut source code nya
   
```awk

#!/bin/bash

awk -F '\t' '{ if ($13 != "Region") a[$13]+=$21;} END{ bool=1;for(i in a)
{
 if(bool==1){min=a[i];bool=0}
 if(min>a[i]){min=a[i];reg=i}
 
} print reg

}' Sample-Superstore.tsv


```
+ Pertama, kita tentukan bahwa separator file tersebut adalah tab lalu kita mengelompokkan kolom region yaitu kolom ke 13 dan menjumlahkan tiap nilai profit dari masing-masing region
```awk
awk -F '\t' '{ if ($13 != "Region") a[$13]+=$21;}
```
+ Hasil dari pengelompokan tersebut dimasukkan ke array a yang terdiri dari nilai profit tiap region. Kemudian melakukan looping untuk mencari nilai minimul dari array tersebut.
```awk
{ bool=1;for(i in a)
{
 if(bool==1){min=a[i];bool=0}
 if(min>a[i]){min=a[i];reg=i}
 
} print reg

}
```
+ dan didapatkan region yang memiliki nilai minimal.
<br>
b. Menentukan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a
    Untuk dapat menentukan 2 state tersebut, maka kita mengambil nilai dari kolom state yang berada di region Central yang sudah didapat di point a, kemudian mengelompokkan kolom state tersebut sesuai namanya untuk bisa mendapatkan jumlah profit tiap statenya dan mencari minimal nya. Berikut source code nya: 

```awk
 #!/bin/bash

awk -F'\t' '{if($13 == "Central") a[$11]+=$21;}END{bool=1;for(i in a)
{
 if(bool==1){min1=a[i];min2=min1;bool=0}
 if(min>a[i]){min2=min1;min1=a[i];state2=state1;state1=i}
 
} print state1, state2

}' Sample-Superstore.tsv
```
+ Langkah pertama kita mengambil nilai dari kolom state kolom ke 11 yang berada di region Central yang sudah didapat di point a, kemudian mengelompokkan kolom state tersebut sesuai namanya dan dimasukkan ke array a. Kemudian mengisi array a dengan jumah profit tiap-tiap state yang bisa diambil di kolom 21
```awk
awk -F'\t' '{if($13 == "Central") a[$11]+=$21;}
```
+ Langkah kedua yaitu mencari 2 nilai minimal nya dengan menggunakan looping for
```awk
{bool=1;for(i in a)
{
 if(bool==1){min1=a[i];min2=min1;bool=0}
 if(min>a[i]){min2=min1;min1=a[i];state2=state1;state1=i}
 
} print state1, state2
}
```
+ lalu didapat 2 negara bagian yang memiliki profit terendah

c. Menentukan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b
   Untuk dapat menentukan 10 produk tersebut, maka kita mengambil nilai dari kolom produk yang berasal dari negara bagian Illinois dan Texas yang sudah didapat di point b, kemudian mengelompokkan kolom produk tersebut tersebut sesuai namanya untuk bisa mendapatkan jumlah profit tiap produknyanya dan mencari minimal nya

```awk
awk -F'\t' '{if($11 == "Illinois"|| $11 == "Texas") a[$17]+=$21;}END{for(x=0;x<10;x++) {{bool=1;for(i in a)
{
 if(bool==1){min=a[i];bool=0}
 if(min>a[i]){min=a[i];prod=i}
 
} print prod; delete a[prod]}
}}' Sample-Superstore.tsv
```

# Soal2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.
#
## Jawab
a. Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka.
b. Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.

```awk
#!/bin/bash
a=$(echo $1 | tr -d [:digit:])
p = "`< /dev/urandom tr -dc A-Z | head -c5`"
q = "`< /dev/urandom tr -dc a-z | head -c5`"
r = "`< /dev/urandom tr -dc 0-9 | head -c5`"
s = "`< /dev/urandom tr -dc A-Za-z0-9 | head -c13`"
pw = $p$q$r$s
echo -e $pw > $a.txt
b=`date +%H`
echo "$a;$b" >> log.csv
```

+ Untuk mengawali program, declare sebuah variabel, pada program ini, variabel tersebut disebut a. nilai daripada parameter pertama diambil, kemudian disaring dan ambil alphabetnya saja
```awk
a=$(echo $1 | tr -d [:digit:])
```
+ Kemudian ditentukan letak-letak masing masing huruf besar, huruf kecil dan angka pada urutan tertentu. /dev/urandom merupakan berkas khusus yang berperan sebagai pseudorandom number generators. pw merupakan variable yang akan menampung hasil gabungan password yang sudah jadi dan akan dimasukkan ke a.txt
```awk
p = "`< /dev/urandom tr -dc A-Z | head -c5`"
q = "`< /dev/urandom tr -dc a-z | head -c5`"
r = "`< /dev/urandom tr -dc 0-9 | head -c5`"
s = "`< /dev/urandom tr -dc A-Za-z0-9 | head -c13`"
pw = $p$q$r$s
echo -e $pw > $a.txt
```
+ Declare sebuah variabel, pada program ini, variabel tersebut disebut b. kemudian diassign dengan nilai date+jam,
dan dimasukkan ke log.csv

```awk
b=`date +%H`
echo "$a;$b" >> log.csv
```
<br>

c.Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.)

```awk
#!/bin/bash
x="$1"

jam=`awk -v x=$x -F ";" 'FNR>1 {if(match($1, x))print $2}' log.csv`

alphabet1=`expr $jam + 97`

alphabetBeforeValue=`expr $jam + 97`

alphabetBefore=`awk -v x=$alphabetBeforeValue 'BEGIN{printf "%c",x}'`

alphabetAfterValue=`expr $alphabetBeforeValue - 1`

alphabetAfter=`awk -v x=$alphabetAfterValue 'BEGIN{printf "%c",x}'`

newName=`echo $x | tr '[a-z]' '['$alphabetBefore'-za-'$alphabetAfter']'`

echo "$newName;$jam" >> log.csv
mv $x.txt $newName.txt
```
+ Declare sebuah variable untuk menampung parameter yang dimasukkan, yang disebut a, kemudian, buat variable untuk mengambil data dari log.csv dengan kunci nama file yang diberikan. Kemudian buat variabel untuk menampung huruf ASCII 'a' + jam yang disebut alphabetBeforeValue. Kemudian variabel selanjutnya adalah untuk menampung nilai dari karakter ASCII yang disebut alphabetBefore.
```awk
x="$1"

jam=`awk -v x=$x -F ";" 'FNR>1 {if(match($1, x))print $2}' log.csv`

alphabet1=`expr $jam + 97`

alphabetBeforeValue=`expr $jam + 97`

alphabetBefore=`awk -v x=$alphabetBeforeValue 'BEGIN{printf "%c",x}'`
```
+ Kemudian perlu dideklarasi lagi variabel untuk menampung nilai satu huruf sebelum karakter alphabetBefore yang disebut alphabetAfterValue, dan juga variabel untuk menampung karakter tersebut yang disebut alphabetAfter, variabel newName berfungsi untuk menampung nama file yang baru dan dimasukkan ke dalam log agar bisa di dekrip kembali. Pada baris terakhir adalah proses rename file.
```awk
alphabetAfterValue=`expr $alphabetBeforeValue - 1`

alphabetAfter=`awk -v x=$alphabetAfterValue 'BEGIN{printf "%c",x}'`

newName=`echo $x | tr '[a-z]' '['$alphabetBefore'-za-'$alphabetAfter']'`

echo "$newName;$jam" >> log.csv
mv $x.txt $newName.txt
```
<br>
d. jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.

```awk
#!/bin/bash
x="$1"
jam=`awk -v x=$x -F ";" 'FNR>1 {if(match($1, x))print $2}' log.csv`
#alphabet1=`expr $jam + 97`
alphabetBeforeValue=`expr $jam + 97`

alphabetBefore=`awk -v x=$alphabetBeforeValue 'BEGIN{printf "%c",x}'`
echo $alphabetBefore

alphabetAfterValue=`expr $alphabetBeforeValue - 1`

alphabetAfter=`awk -v x=$alphabetAfterValue 'BEGIN{printf "%c",x}'`
echo $alphabetAkhir
echo $x

newName=`echo $x | tr '['$alphabetBefore'-za-'$alphabetAfter']' '[a-z]'`

echo "$newName"
mv $x.txt $newName.txt
```

+ Pada file dekrip, kebanyakan command yang digunakan mirip dengan pada file enkripsi. Pertama kita declare variable untuk menampung parameter yang disebut a. Kemudian variable jam untuk menampung data yang diambil dari log.csv. Kemudian deklarasi variable untuk menampung huruf ASCII 'a' + jam yang disebut alphabetBeforeValue, dan juga variabel untuk menampung nilai dari karakter ASCII yang disebut alphabetBefore.
```awk
x="$1"
jam=`awk -v x=$x -F ";" 'FNR>1 {if(match($1, x))print $2}' log.csv`
#alphabet1=`expr $jam + 97`
alphabetBeforeValue=`expr $jam + 97`

alphabetBefore=`awk -v x=$alphabetBeforeValue 'BEGIN{printf "%c",x}'`
echo $alphabetBefore
```

+ Kemudian declare sebuah variabel untuk menampung nilai dari karakter ASCII, satu huruf sebelum alphabetBefore yang disebut alphabetAfterValue, dan variabel selanjutnya untuk menyimpan karakternya yang disebut alphabetAfter. Pada variabel newName, variabel ini berfungsi untuk menyimpan nama baru yang telah di dekripsi. Kemudian nama tersebut dimasukkan ke log.csv, dan command terakhir adalah untuk me rename file tersebut
```awk
alphabetAfterValue=`expr $alphabetBeforeValue - 1`

alphabetAfter=`awk -v x=$alphabetAfterValue 'BEGIN{printf "%c",x}'`
echo $alphabetAkhir
echo $x

newName=`echo $x | tr '['$alphabetBefore'-za-'$alphabetAfter']' '[a-z]'`

echo "$newName"
mv $x.txt $newName.txt
```

# Soal3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk

menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".
#

## Jawab
a. Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk
menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan

+ Kita buat suatu perulangan untuk mendownload file yang berada pada link, perintah wget merupakan perintah untuk mendownload file yang diinginkan, -O merupakan perintah untuk memberi nama pada file kita kemudian di store ke dalam lokasi yang kita inginkan. Dan -a wget.log untuk memasukkan perintah ke dalam log.

```awk
#!/bin/bash

for (( i=1; i<29; i++ ))
do
  wget -O /home/hao/Documents/SistemOperasi/soal3/pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a "wget.log";
done
```

<br>

b. setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi.

+ Untuk menjalankan perintah pada waktu yang diinginkan, kita perlu memasukkan command ke dalam crontab, command tersebut adalah sebagai berikut
```awk
5 6-23/8 * * 0-5 /bin/bash /home/hao/Documents/SistemOperasi/soal3/soal3.sh
```
+ 5 berarti, perintah akan selalu dilakukan pada menit ke 5, 6-23/8 berarti, perintah akan dilakukan mulai jam 6 hingga jam 23, setiap 8 jam sekali, dan 0-5 berarti perintah akan dilakukan setiap hari senin sampai hari jumat.

<br>

c. Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".

<br>

```sh
cat wget.log | grep Location: > location.log
```
mengcopy tiap isi yang diterima asd.log kedalam location.log

```
mkdir duplicate 
mkdir kenangan
```
Untuk membuat file kenangan dan duplicate
```
temp=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)
temp1=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)
```
Berfungsi untuk membuat variable count yang akan menyimpan indeks angka terakhir nama file yang ada di dalam folder.
```
awk '{ printf("%s\t%02d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > file.log
```
Berungsi untuk mengambil string dari location.log kemudian diletakkan di file file.log dengan menambahkan index dengan format ```%02d``` dengan separator tab.
``` sort -n -k1``` untuk sorting isi string di file location.org 

```-n ``` untuk mengurutkan secara numerik string

```-k1``` untuk mengurutkan pada kolom ke 1
```awk -F '\t' -v temp=$temp -v temp1=$temp1 '{ i = $2+0; 
		if( L != $1 ){
			  L = $1; 
			  move = " mv pdkt_kusuma_" i " kenangan/kenangan_" temp1+1 ; temp1++; }
				system(move); } 
  		else if( L == $1 ) { 
			
			move = " mv pdkt_kusuma_" i " duplicate/duplicate_" temp+1; temp++; } ' file.log 

for name in *.log; 
do 
	mv "$name" "${name%.log}.log.bak"
done
````
Selanjutnya yaitu membandingkan string perbaris yang telah di urutkan sebelumnya. Jika berbeda maka akan masuk ke kondisi if dan file di pindah kan ke folder kenangan. Apa bila string yang dibandingkan sama maka file akan dipindahkan ke folder duplicate.

```i = $2+0;``` berfungsi untuk menghilangkan 0 di depan angka index.

```system(move)``` berfungsi untuk menjalankan ```move```

```awk
for name in *.log; 
do 
	mv "$name" "${name%.log}.log.bak"
done
```
untuk mengubah semua name berekstensi .log menjadi ekstensi .log.bak
