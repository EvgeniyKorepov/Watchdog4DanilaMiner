# Watchdog4DanilaMiner
Watchdog for Danila miner

Скачать : https://github.com/EvgeniyKorepov/Watchdog4DanilaMiner/releases/latest/download/Watchdog4DanilaMiner.7z

Watchdog ничего не майнит разработчику, не берет никакие проценты. 
Отблагодарить создателя вы можете задонатив Ton на адрес EQAIxel94QQBAiArH5taFYL0Lwntnhk79-AmcA23BvQsFUtc

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

  // Список пулов
	"PoolUrls" : [
		"https://pool.services.tonwhales.com",
		"https://ton-pool-server-p3agi.ondigitalocean.app"
	],

  // Ключевые слова инициирующие перезапуск майнера
	"RestartTags" : [
		"error",
		"hashrate 0.0"
	],

  // Ключевые слова инициирующие перезапуск майнера с сменой пула
	"PoolChangeTags" : [
		"Connection error. Check pool address."
	]

}
```

Запуск :
Без парамеров Watchdog4DanilaMiner.exe использует конфиг Watchdog4DanilaMiner.json из той же папки откуда запускается.
В параметре можно прописать путь к произвольному файлу конфига, например:
`Watchdog4DanilaMiner.exe C:\Mining\Ton_danila-miner\Watchdog4DanilaMiner\Watchdog4DanilaMiner3090.json`

![image](https://user-images.githubusercontent.com/35364901/144058493-49980455-3f06-40ee-b748-74b282f935a6.png)

