TestProf.configure do |config|
  # путь для сохранения артефактов, например, отчётов ('tmp/test_prof' по умолчанию)
  config.output_dir = "tmp/test_prof"

  # использования уникальных имён для артефактов путём добавления временных меток в название
  config.timestamps = true

  # подсвечивать вывод
  config.color = true
end