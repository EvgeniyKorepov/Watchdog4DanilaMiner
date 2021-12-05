# Watchdog4DanilaMiner
Watchdog for Danila miner

Watchdog ничего не майнит разработчику, не берет никакие проценты. 
Отблагодарить создателя вы можете задонатив Ton на адрес EQAIxel94QQBAiArH5taFYL0Lwntnhk79-AmcA23BvQsFUtc

Скачать : https://github.com/EvgeniyKorepov/Watchdog4DanilaMiner/releases/latest/download/Watchdog4DanilaMiner.7z

## Запуск:
1. В файле Watchdog4DanilaMiner.json укажите полный путь к файлу danila-miner.exe и свой кошелек
2. Запустите Watchdog4DanilaMiner.exe

## Новое:
Теперь вы можете посмотреть статистику и состояние ваших ригов онлайн на странице https://korepov.com/ton/
![image](https://user-images.githubusercontent.com/35364901/144742810-14af620a-6046-44b1-a6ba-df29c761d885.png)
Так же можно получать json данные для прикручивания к майнерским OS:
https://korepov.com/ton/?wallet=EQAIxel94QQBAiArH5taFYL0Lwntnhk79-AmcA23BvQsFUtc&format=json

## Описание:

Watchdog запускает danila-miner.exe с параметрами заданными в конфиг-файле, анализирует вывод майнера, перезапускает майнер при нахождении ключевых слов.
Дополнительно считает средний хешрейт (среднее арифметическое последних 50 показаний майнера) и количество шар.

Конфиг:
```
{
  	// Путь к майнеру
	"MinerFilePath" : "C:\Mining\Ton_danila-miner\danila-miner.exe",
  	// Дополнительные параметры, к примеру -p 0 -d 0
	"MinerParams" : "",
  	// Адрес вашего кошелька
	"WalletAddress" : "EQAIxel94QQBAiArH5taFYL0Lwntnhk79-AmcA23BvQsFUtc",
	// Название рига (для статистики на https://korepov.com/ton/)
	"RigName" : "Home sweet home",	

  	// Путь к логфайлу (если запускате несколько экземпляров, то лучше каждому свой лог)
	"LogFileName" : "Watchdog4DanilaMiner.log",	
	// Таймаут чтения консоли майнера
	"ConsoleReadTimeoutSec" : 45,	

  	// Список пулов
	"PoolUrls" : [
		"https://server1.whalestonpool.com",	
		"https://pool.services.tonwhales.com",
		"https://ton-pool-server-p3agi.ondigitalocean.app"
	],

  	// Ключевые слова инициирующие перезапуск майнера
	"RestartTags" : [
		"error",
		"hashrate 0.0",
		"WRONG HASH"
	],

  	// Ключевые слова инициирующие перезапуск майнера с сменой пула
	"PoolChangeTags" : [
		"Connection error. Check pool address.",
		"Max retries exceeded with url",
		"Connection aborted",
		"Unknown error"
	]

}
```

## Запуск с параметром :
Без парамеров Watchdog4DanilaMiner.exe использует конфиг Watchdog4DanilaMiner.json из той же папки откуда запускается.
В параметре можно прописать путь к произвольному файлу конфига, например:
```
Watchdog4DanilaMiner.exe C:\Mining\Ton_danila-miner\Watchdog4DanilaMiner\Watchdog4DanilaMiner3090.json
```

![image](https://user-images.githubusercontent.com/35364901/144722425-b32c4cd4-868a-49f9-9625-1403870c0322.png)

