# WeatherScript
For data on HK weather from their public API [Docs](https://www.hko.gov.hk/en/weatherAPI/doc/files/HKO_Open_Data_API_Documentation.pdf)  
Uses `poetry(v. 1.1.4)` for package management  
Dependencies:
- `requests`
- `urllib`  
Usage:
`
weather_obj = weatherInstance(config_file, /
  					debug_state, 'data_logs_dir,
								'debug_logs dir')
`  
`debug_state`: `True` or `False`  
`data_logs_dir`  
- Files written here if not in debug mode
- Each Area and report type has new logfile created
`debug_logs_dir`  
- Timed logs created here
- All data instances logged in one file with timestamp
  
config_file in `.ini` format
>			[URLS]
>			url: <API URL>
>			[rainfall]
>			1. Area 1
>			2. Area 2
>			[temperature]
>			1. Area 1

> weather_obj.log_data()  
Final call to object to log data to destination selected
