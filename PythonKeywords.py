# To use this file in your tests use "Library  resources/PythonKeywords.py"
import psycopg2
from psycopg2 import sql


class PythonKeywords:
    counter = 0

    # Use Get Next Int in robot to get a new number
    @staticmethod
    def get_next_int():
        PythonKeywords.counter = PythonKeywords.counter + 1
        return PythonKeywords.counter


class DBConect:
    self.csr = ""
    def __init__(self, hn, db, ur, pw):
        cxn = psycopg2,connect(("host=%s dbname=%s user=%s password=%s").format(hn, db, ur, pw))
        self.csr = cxn.cursor()

    def get_sdts(self, ):
        self.csr.execute("Select * From product_catalogue.service_delivery_type")

    def __del__(self):
        self.cxn.close()

if __name__ == '__main__':
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    print(PythonKeywords.get_next_int())

    db = DBConect('localhost', 'postgres', 'postgres', 'root')
