# Laboratorium 8 - Zadanie P8.2

### P8.2
>
>  W poprzednim zadaniu utworzone były dwa kontenery T1 oraz T2 przyłączone do mostu doker (domyślny tryb sieciowy). Proszę ręcznie utworzyć kontener T2 a potem uruchomić T1 linkowany do T2. W sprawozdaniu proszę podać użyte polecenia oraz zawartość pliku hosts  zmienne systemowe na kontenerze T1 oraz T2.

Użyto następujących poleceń do linkowania:
```bash
docker run -itd --name T2 -p 80:80 alpine
docker run -itd --name T1 --link T2:mylink alpine
```
Do sprawdzenia czy linkowanie przebiegło pomyślnie użyto następujących poleceń
`docker exec T1 ping -c 4 mylink`

![image](https://user-images.githubusercontent.com/47278535/168481548-efad0d66-5829-43a3-b92a-afe5a8d76284.png)

Użycie polecenia `docker exec T1 cat /etc/hosts`, pokazało następujący rezultat

![image](https://user-images.githubusercontent.com/47278535/168481588-2c6d669e-191b-49a3-b65e-27f369de2f2b.png)
Kolumna z nazwą mylink pokazuje adres oraz nazwę kontenera którą zlinkowaliśmy

Za pomocą polecenia `docker exec T1 printenv | grep MYLINK`, możemy zobaczyć na jakim porcie jest linkowany adres 
![image](https://user-images.githubusercontent.com/47278535/168481633-822eb0d0-12af-4b2a-b301-aa1b5b3a94c8.png)

Nieudana próba pingu z kontenera T2 prezentuje się następująco

![image](https://user-images.githubusercontent.com/47278535/168481700-0c2c3d82-de4a-4a6d-b474-e6dc1de25543.png)


### 1. Czy link jest dwukierunkowy, tj czy na bazie utworzonego linku można komunikować się (np.pingować) z kontenera T2 na T1. Odpowiedź proszę uzasadnić.

Utworzony link działa tylko na kontenerze T1, jeżeli chcemy komunikować się z kontenera T2 -> T1, to musimy znać adres jaki posiada konterner T1

### 2. Czy w pozostałych trybach tj. w sieciach wykorzystujących User-defined Network Driver oraz Host Network Driver jest możliwe tworzenie linków. Jeśli tak, zaprezentuj przykładową budowę linku, jeśli nie to uzasadnij odpowiedź.

Przy próbie tworzenia linku w sieci Host Network Driver docker wypluwa następujący błąd:

![image](https://user-images.githubusercontent.com/47278535/168479699-1d8835a8-5356-4b29-8d52-466e54028ad0.png)

Zatem tworzenie linków możliwe jest w sieciach User-defined Network.
Utworzenie przykładowych kontenerów, wykorzystujących sieć zdefiniowaną przez użytkownika:

![image](https://user-images.githubusercontent.com/47278535/168479658-774cab78-36f4-443e-b962-7475fdec7f95.png)

> informacje dotyczące utworzonej nowej sieci
> 
>![image](https://user-images.githubusercontent.com/47278535/168479860-7886d59e-9624-4f51-8c10-62066a546796.png)

Powyższy zrzut ekranu przedstawia prawidłowe podpięcie linka do kontenera, na co wskazuje poprawne wykonanie się polecenia ping

### 3. Czy możliwe jest tworzenie linków pomiędzy sieciami skonfigurowanymi w różnych trybach sieciowych. Odpowiedź uzasadnij.
Przy próbie zlinkowania konternera będącego w sieci defaultowej (docker0) do kontenera będącego w innej sieci zdefiniowanej przez użytkownika pojawia się błąd iż kontener z innej sieci nie należy do sieci domyślnej stąd, tworzenie linków między różnymi trybami jest nie możliwe

![image](https://user-images.githubusercontent.com/47278535/168481270-82b6f217-22ef-4006-8a27-9af8c325dbcc.png)
