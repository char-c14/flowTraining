import sys, json
from datetime import datetime
import requests, logging, configparser

def setup_logger(name, log_file, level=logging.INFO):
    handler = logging.FileHandler(log_file)        
    logger = logging.getLogger(name)
    logger.setLevel(level)
    logger.addHandler(handler)

    return logger

class weatherInstance:
	def __init__(self, config_file='config.ini', debug_state=False, data_path='data_logs', debug_path='debug_logs'):
		self.config_file = config_file
		self.debug_state = debug_state
		self.data_path = data_path
		self.debug_path = debug_path

	def log_data(self):
		if self.debug_state:
			file_dest = self.debug_path + '/' + datetime.now().strftime("%Y%m%d, %H:%M:%S") + '.log'
			logging.basicConfig(filename=file_dest, level=logging.DEBUG)

		config = configparser.ConfigParser()
		config.read(self.config_file)
		response_raw = requests.get(config['URLS']['url'])
		response_dict = response_raw.json()

		# print(json.dumps(response_dict, indent=2))

		for report_type in config.sections():
			if report_type == "URLS":
				continue

			for key in config[report_type]:
				report_loc = config[report_type][key]
				data_found = False
				for data_entry in response_dict[report_type]['data']:
					if data_entry['place'] == report_loc:
						if not self.debug_state:
							file_dest = self.data_path+'/' + datetime.now().strftime("%Y%m%d") + '_' +report_type + '_' + report_loc + '.log'
							data_handling = setup_logger(report_loc+report_type, file_dest, logging.INFO)
							data_handling.info(datetime.now().strftime("%H:%M:%S") + ' : ' + json.dumps(data_entry))
						else:
							logging.info(data_entry)
						data_found = True
						break
				if not data_found and self.debug_state:
					logging.warning('Data for ' + report_loc + ' ' + report_type + ' missing')


if __name__ == '__main__':
	debug_state = False
	if len(sys.argv) == 2:
		if sys.argv[1] == '--DEBUG':
			debug_state = True
	weather_obj = weatherInstance('../config.ini', debug_state, 'data_logs', 'debug_logs')
	weather_obj.log_data()

def run():
	debug_state = False
	if len(sys.argv) == 2:
		if sys.argv[1] == '--DEBUG':
			debug_state = True
	weather_obj = weatherInstance('config.ini', debug_state, 'data_logs', 'debug_logs')
	weather_obj.log_data()
	

