import psycopg2
from psycopg2 import sql

class RobotDB:
    def __init__(self, hn, db, ur, pw):
        self.cxn = psycopg2.connect(("host={0} dbname={1} user={2} password={3}").format(hn, db, ur, pw))
        self.csr = self.cxn.cursor()

    def get_test(self):
        self.csr.execute("Select * From public.test_table")

    def get_sdts(self):
        self.csr.execute("Select * From product_catalogue.service_delivery_type")

    def get_forms(self, a_id):
        self.csr.execute(sql.SQL("Select form_id From product_catalogue.activity_form Where activty_id in (%s)").format(a_id,))

    def get_result(self):
        return self.csr.fetchall()

    def __del__(self):
        self.cxn.close()
