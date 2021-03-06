# Machine Learning Box

## Prerequisites

 - VirtualBox - https://www.virtualbox.org/
 - Vagrant - https://www.vagrantup.com/
 
## Was?

 - Ubuntu Groovy 20.10 - MATE Desktop
 - VirtualBox Guest Additions
 - Python3, Tensorflow, Keras
 - Atom (Beta) Editor with Python IDE
 - Firefox
 - Gemeinsamer Ordner `workspace` kann aus der VM und auf dem Host editiert werden
 - Jupyter Notebook auf http://localhost:8888/
 
## Wie?

 - VirtualBox und Vagrant installieren
 - Dieses Projekt per Git clonen oder als ZIP runterladen
 - Terminal in dem Verzeichnis starten und `vagrant up` ausführen
 - Install local plugins (Y/N) - `YES`
 - Wieder `vagrant up`
 - Die Virtuelle Machine wird gebaut und steht nach der Provisionierung zur Verfügung
 
 ## Noch was?
 
 - `vagrant up` - Virtuelle Maschine hochfahren (dauert das erste Mal länger wegen der Provisionierung)
 - `vagrant halt` - Virtuelle Maschine runterfahren
 - `vagrant reload` - Virtuelle Maschine neu starten
 - `vagrant destroy` - Virtuelle Maschine löschen
 - `vagrant ssh` - Secure Shell Verbindung in die Virtuelle Maschine
 - Username: `vagrant` Passwort: `vagrant`