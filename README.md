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
   
```sh

#!/bin/bash

awk -F '\t' '{ if ($13 != "Region") a[$13]+=$21;} END{ bool=1;for(i in a)
{
 if(bool==1){min=a[i];bool=0}
 if(min>a[i]){min=a[i];reg=i}
 
} print reg

}' Sample-Superstore.tsv


```
+ Pertama, kita tentukan bahwa separator file tersebut adalah tab lalu kita mengelompokkan kolom region yaitu kolom ke 13 dan menjumlahkan tiap nilai profit dari masing-masing region
```sh
awk -F '\t' '{ if ($13 != "Region") a[$13]+=$21;}
```
+ Hasil dari pengelompokan tersebut dimasukkan ke array a yang terdiri dari nilai profit tiap region. Kemudian melakukan looping untuk mencari nilai minimul dari array tersebut.
```sh
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

```bash
 #!/bin/bash

awk -F'\t' '{if($13 == "Central") a[$11]+=$21;}END{bool=1;for(i in a)
{
 if(bool==1){min1=a[i];min2=min1;bool=0}
 if(min>a[i]){min2=min1;min1=a[i];state2=state1;state1=i}
 
} print state1, state2

}' Sample-Superstore.tsv
```
+ Langkah pertama kita mengambil nilai dari kolom state kolom ke 11 yang berada di region Central yang sudah didapat di point a, kemudian mengelompokkan kolom state tersebut sesuai namanya dan dimasukkan ke array a. Kemudian mengisi array a dengan jumah profit tiap-tiap state yang bisa diambil di kolom 21
```bash
awk -F'\t' '{if($13 == "Central") a[$11]+=$21;}
```
+ Langkah kedua yaitu mencari 2 nilai minimal nya dengan menggunakan looping for
```bash
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

```bash
awk -F'\t' '{if($11 == "Illinois"|| $11 == "Texas") a[$17]+=$21;}END{for(x=0;x<10;x++) {{bool=1;for(i in a)
{
 if(bool==1){min=a[i];bool=0}
 if(min>a[i]){min=a[i];prod=i}
 
} print prod; delete a[prod]}
}}' Sample-Superstore.tsv
```

