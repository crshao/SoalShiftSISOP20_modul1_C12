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
+ Pada file dekrip, kebanyakan command yang digunakan mirip dengan pada file enkripsi. Pertama kita declare variable untuk menampung parameter yang disebut a. Kemudian variable jam untuk menampung data yang diambil dari log.csv. Kemudian deklarasi variable untuk menampung huruf ASCII 'a' + jam yang disebut alphabetBeforeValue, dan juga variabel untuk menampung nilai dari karakter ASCII.
