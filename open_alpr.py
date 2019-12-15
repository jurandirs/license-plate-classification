from openalpr import Alpr
import sys

# https://pypi.org/project/openalpr/
# https://github.com/openalpr/openalpr
# https://github.com/openalpr/openalpr/blob/master/src/bindings/python/test.py
# https://github.com/openalpr/openalpr/issues/660


# alpr = Alpr("us", "/path/to/openalpr.conf", "/path/to/runtime_data")
alpr = Alpr("br", "/etc/openalpr/openalpr.conf", "/usr/share/openalpr/runtime_data")
if not alpr.is_loaded():
    print("Error loading OpenALPR")
    sys.exit(1)
    
alpr.set_top_n(20)
alpr.set_default_region("md")

results = alpr.recognize_file("capturies/foto2.jpeg")
print(results)
i = 0
for plate in results['results']:
    i += 1
    print("Plate #%d" % i)
    print("   %12s %12s" % ("Plate", "Confidence"))
    for candidate in plate['candidates']:
        prefix = "-"
        if candidate['matches_template']:
            prefix = "*"

        print("  %s %12s%12f" % (prefix, candidate['plate'], candidate['confidence']))

# Call when completely done to release memory
alpr.unload()