LegoBoxViewer - simple 3D views of LEGO boxes
==============================================

SETUP
Put these files together in one folder (for example a folder called LegoBoxViewer):
  LegoBoxViewer.html       the viewer
  update-folders.bat       Windows helper (see below)
  update-folders.sh        Mac / Linux helper
  metadata.example.json    example for the information card
  README.txt               this file
  index.html               opens LegoBoxViewer.html, so a web address without a file name works
  .nojekyll                (empty) tells GitHub Pages to serve the files as they are
Next to them, make a folder called "images" and put one folder per box in it (see below).
update-folders also creates the "images" folder if it is missing.

Open LegoBoxViewer.html in a browser. Double-clicking it works, no server needed.
You can also put the whole folder on any web server.


CONTROLS
- Rotate:  drag with the left mouse button (one finger on a touch screen).
- Move:    hold both mouse buttons and drag (the right or middle button alone works too;
           two fingers on a touch screen).
- Zoom:    scroll wheel, or pinch.
- Reset view puts the box back in the middle.
- Click a side (or tap it) to see its picture full screen, flat. In that view:
    Zoom:       scroll wheel (zooms in where the mouse points), pinch, the - / + buttons or keys,
                Fit (key 0) or 100% = actual pixels (key 1). Double-click or double-tap switches
                between fit and zoomed in.
    Move:       drag the picture, use the scrollbars, or Shift + scroll wheel to go sideways.
    Pictures:   the < > arrows, the left / right arrow keys, or a swipe (when not zoomed in)
                go through the box's other pictures.
    Close:      Esc, the Close button, or click beside the picture.
- Boxes with a lid open with the "Open lid" button.
- The Gallery button (or the G key) opens all of the box's pictures full screen, starting with
  the top; it works the same way as clicking a side (zoom, move, arrows to go through them).

Pick a box in the menu on the left (on a phone, tap the ☰ button). Each menu item shows a small
copy of that box's top.jpg, the folder name and, if metadata.json has one, the set name.
Boxes whose metadata.json has a bricklinkMenu are grouped the same way as on BrickLink, for example
Sets > Pirates > Pirates I. Click a group's name to fold it in or out; the number is how many boxes
it holds. Boxes without a bricklinkMenu are listed after the groups.
The page background takes its colours from the shown box's top.jpg (a strongly blurred copy of it)
and changes when you pick another box.
The address ends with #<box name>, so you can bookmark or share a link to one box.


ONE FOLDER PER BOX
------------------
Every folder inside "images" is one box, and the folder's name is its name in the menu:

  images/
    6285/              <- menu item "6285"
      top.jpg
      front.jpg
      ...
      metadata.json    <- optional, shows the information card (see below)
    6276/              <- menu item "6276"
      ...
    folders.js         <- made by update-folders, don't edit by hand

The menu is sorted by name (6276 comes before 6285, 10 comes after 9), inside the BrickLink
groups from each box's metadata.json (see INFORMATION CARD).


ADDING, RENAMING OR REMOVING A BOX, OR CHANGING ITS metadata.json
-----------------------------------------------------------------
1. Add, rename or delete the folder inside "images", or change its metadata.json.
2. Update the list of folders:
     Windows:        double-click update-folders.bat
     Mac / Linux:    run ./update-folders.sh
3. Reload the page.

Changing only pictures inside an existing folder needs no step 2, just reload.

Why step 2: a web page opened from disk is not allowed to look inside folders or read files by
itself. The scripts write the folder names, and a copy of each metadata.json, into images/folders.js.
On a web server that shows folder listings (for example Apache with directory listing turned on),
the page finds the folders and reads metadata.json itself, so step 2 is not needed there.
Avoid quotes (" and '), & and % in folder names.


PICTURES IN A BOX FOLDER
------------------------
Names must be lower-case. Any of .jpg, .jpeg, .png, .webp or .avif works (for example front.jpg or
front.avif), and one box can mix them. If two files share a name, the order used is .jpg, .jpeg, .png,
.webp, .avif.
AVIF gives about half the file size of JPEG at the same quality. It needs a recent browser:
Chrome / Edge 85+, Firefox 93+, Safari 16.4+ (iPhone / iPad on iOS 16.4+). In an older browser an
.avif face shows a placeholder saying it can't be shown.
If a picture is missing, its face shows a yellow placeholder with the file name it is looking for.

File               What it is
top.jpg            Top of the box (the lid, if it has one)
lid-inside.jpg     Inside of the lid flap
front.jpg          Front side
back.jpg           Back side
left.jpg           Left short side
right.jpg          Right short side
bottom.jpg         Bottom
card.jpg           Window card under the lid, with the contents showing through its windows,
                   seen from above

BOX WITHOUT A LID
If a folder has only the six outside pictures (top, front, back, left, right, bottom) and neither
lid-inside.jpg nor card.jpg, that box is shown closed, with no lid to open.

BOX SHAPE FOLLOWS top.jpg AND left.jpg
Each box takes its proportions from its own pictures. The width is always the same.
- Depth comes from top.jpg:   depth  = width x (top.jpg height / top.jpg width)
- Height comes from left.jpg: height = depth x (left.jpg height / left.jpg width)
All other faces, the inner box and the card adjust to match.
So crop top.jpg and left.jpg tightly to the edges of the box; the others are stretched to fit.
(boxSize in metadata.json is only shown on the information card; it does not change the shape.)


INFORMATION CARD (metadata.json)
--------------------------------
If a box folder contains a file called metadata.json, a card with the set's details is shown in
the top right corner (above the buttons on a phone). Without the file, there is no card.
metadata.example.json next to this README is a ready-made example to copy:

{
  "name": "Black Seas Barracuda",
  "year": 1989,
  "boxSize": { "width": 57.7, "depth": 46.4, "height": 9.4 },
  "bricklink": "https://www.bricklink.com/v2/catalog/catalogitem.page?S=6285-1",
  "instructions": "https://www.bricklink.com/v2/catalog/catalogitem.page?I=6285-1",
  "bricklinkMenu": ["Sets", "Pirates", "Pirates I"]
}

name           Name of the set, shown as the card's title (the folder name is used if left out)
               and under the folder name in the menu.
year           Year of release, shown on the card as "Released 1989".
boxSize        Outside size of the box in cm: width (front, left to right), depth (front to back)
               and height. Shown on the card as "Box 57.7 x 46.4 x 9.4 cm" (only shown, the
               box's shape still comes from the pictures). These forms also work:
                 "boxSize": [57.7, 46.4, 9.4]                       (width, depth, height)
                 "boxSize": "57.7 x 46.4 x 9.4 cm"                  (cm, mm or in)
                 "boxSize": { "width": 577, "depth": 464, "height": 94, "unit": "mm" }
bricklink      Link to the set on BrickLink, shown as a "BrickLink" button.
instructions   Link to the instructions, shown as an "Instructions" button.
bricklinkMenu  BrickLink menu tree, top level first. Shown on the card as  Sets > Pirates > Pirates I,
               and the box is put in that same group in the menu on the left.
               An entry can also be a link: {"name": "Pirates", "url": "https://www.bricklink.com/..."}
               (the link works on the card; the menu only uses the name).

Every field is optional. Only links starting with http:// or https:// are used; others are ignored.
Links open in a new tab.
If the file has a mistake (for example a comma after the last item), the card says so and shows
where the mistake is.
If the card says metadata.json "is there, but the page doesn't have it yet": run update-folders
(from this version of the package) and reload. Opened from disk, the page only knows what
update-folders copied into images/folders.js.
If the card mentions metadata.json.txt: Windows hid a ".txt" ending. In Explorer turn on
View > File name extensions, rename the file to metadata.json, run update-folders and reload.
Don't use the characters */ anywhere in the file, because update-folders copies it into
images/folders.js and */ would break that copy.


WHICH WAY UP
------------
- Sides: upright, the way you read them standing in front of that side.
- top.jpg and card.jpg: as seen from above, with the box's front edge at the bottom of the picture.
- lid-inside.jpg: as you see it with the lid open; the bottom of the picture is the hinge.
- bottom.jpg: as you see it after turning the box over sideways (left to right). The top of the picture is the box's back edge.


LICENCE
-------
Copyright (c) 2026 

LegoBoxViewer (the code, this README and the photos taken by the author) is licensed under the
Creative Commons Attribution-NonCommercial 4.0 International licence (CC BY-NC 4.0):
https://creativecommons.org/licenses/by-nc/4.0/

In short, you may:
- share it: copy and pass it on in any medium or format;
- adapt it: change it and build on it;
as long as you:
- give credit: name the author, link to the licence and say if you made changes;
- don't use it commercially: not for anything mainly meant for money or a commercial advantage,
  such as selling it or using it in a paid product or service.
This summary is not the licence; the full legal text at the link above is what applies.
For commercial use, ask the author for permission.

LEGO® is a trademark of the LEGO Group of companies, which does not sponsor, authorise or endorse
this project. Box artwork that appears in the photos is © the LEGO Group and is not covered by
this licence.


If you find my work useful, please consider supporting me on Buy me a Coffee: https://buymeacoffee.com/epamsmail
