# To use this file in your tests use "Library resources/PythonKeywords"
class PythonKeywords:
    counter = 0

    # Use Get Next Int in robot to get a new number
    @staticmethod
    def get_next_int():
        PythonKeywords.counter = PythonKeywords.counter + 1
        return PythonKeywords.counter


if __name__ == '__main__':
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    PythonKeywords.get_next_int()
    print(PythonKeywords.get_next_int())
