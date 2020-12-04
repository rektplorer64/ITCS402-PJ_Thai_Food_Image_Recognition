import os

def extract_label_from_url(file_path):
  # convert the path to a list of path components
  return file_path.split(os.path.sep)[-2]
