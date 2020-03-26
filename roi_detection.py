from PIL.Image import *
from math import sqrt


image = open("mouse2.png")


def get_pixels_with_color(image, color):
    (height, width) = image.size
    l = []
    for w in range(height):
        for v in range(width):    
            (r, g, b, a) = image.getpixel((w, v))
            if g > color and v < width*0.83:
                #i.putpixel((w, v), (255, 0, 0, 255))
                l.append([w, v])

    return l

def distance(p1, p2):
    return sqrt((p1[0] - p2[0])*(p1[0] - p2[0]) + (p1[1] - p2[1])*(p1[1] - p2[1]))

def get_roi(l):
    tmp = []
    moyenne = []
    n = len(l)
    for k in range(n):
        longueur = 0
        largeur = 0
        for t in range(k, n):
            if distance(l[k], l[t]) < 1:
                tmp.append(l[t])
                #l.remove(l[t])
                n = len(l)

        for w in range(len(tmp)):
            longueur += tmp[w][0]
            largeur += tmp[w][1]

        longueur /= len(tmp)
        largeur /= len(tmp)
        moyenne.append([longueur, largeur])
        tmp = []
         

    for liste in moyenne:
        image.putpixel((int(liste[0]), int(liste[1])), (255, 0, 0, 255))
    
    Image.show(image)

#print(moyenne)

liste = get_pixels_with_color(image, 150)
get_roi(liste)
