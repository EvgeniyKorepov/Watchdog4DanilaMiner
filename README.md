# Watchdog4DanilaMiner
Watchdog for Danila miner

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
