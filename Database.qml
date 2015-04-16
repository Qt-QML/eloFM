import QtQuick 2.3
import QtQuick.LocalStorage 2.0
import "Themes.js" as Themes

Item {
    function createDatabase() {
        var db = LocalStorage.openDatabaseSync("Database", "1.0",
                                               "My data.", 1000000)
        db.transaction(function (tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS Theme(number SMALLINT)')
            var rs = tx.executeSql('SELECT * FROM Theme LIMIT 1')
            if (rs.rows.length === 0)
                tx.executeSql('INSERT INTO Theme VALUES(6)') // start theme
            rs = tx.executeSql('SELECT * FROM Theme')
            Themes.set(rs.rows.item(0).number)
            colorSchemeIterator = rs.rows.item(0).number + 1

            //tx.executeSql('DROP TABLE IF EXISTS RadioStations')
            tx.executeSql(
                        'CREATE TABLE IF NOT EXISTS RadioStations(title TEXT, source TEXT, favorite SMALLINT)')
            rs = tx.executeSql('SELECT * FROM RadioStations LIMIT 1')
            if (rs.rows.length === 0) {

                // POLSKIE RADIO
                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Jedynka', 'http://stream3.polskieradio.pl:8900', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Dwójka', 'http://stream3.polskieradio.pl:8902', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Trójka', 'http://stream3.polskieradio.pl:8904', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Czwórka', 'http://stream3.polskieradio.pl:8906', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Poland', 'http://stream3.polskieradio.pl:8908', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polskie Radio 24', 'http://stream3.polskieradio.pl:8080', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Радио Польша', 'http://stream3.polskieradio.pl:8914', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Rytm', 'http://stream3.polskieradio.pl:8910', '0'])

                // GRUPA RMF
                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['RMF FM', 'http://195.150.20.242:8000/rmf_fm', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['RMF Classic', 'http://31.192.216.5:8000/rmf_classic', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['RMF Maxxx', 'http://31.192.216.6:8000/rmf_maxxx', '0'])

                // EUROZET
                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio ZET', 'http://radiozetmp3-01.eurozet.pl:8400', '0'])
                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Zet Gold', 'http://zgl-wro-01.cdn.eurozet.pl:8822', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio ZET Chilli', 'http://chillizetmp3-01.eurozet.pl:8400', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['AntyRadio', 'http://ant-waw.cdn.eurozet.pl:8602', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Plus', 'http://s3.deb1.scdn.smcloud.net/t051-1.mp3', '0'])

                // GRUPA RADIOWA TIME
                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Eska', 'http://s3.deb1.scdn.smcloud.net/t042-1.mp3', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Eska Rock', 'http://s3.deb1.scdn.smcloud.net/t041-1.mp3', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio WAWA', 'http://publish.acdn.smcloud.net:8000/t050-1.mp3', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio VOX FM', 'http://s3.deb1.scdn.smcloud.net/t049-1.mp3', '0'])

                // GRUPA RADIOWA AGORY
                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio TOK FM', 'http://mainstream.radioagora.pl/tok_64.mp3', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Złote Przeboje', 'http://wroclaw.radio.pionier.net.pl:8000/pl/tuba9-1.mp3', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Rock Radio', 'http://mainstream.radioagora.pl:8006', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Blue FM', 'http://mainstream.radioagora.pl:80/bluefm.mp3', '0'])

                // POZOSTAŁE
                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Muzo FM', 'http://stream4.nadaje.com:8002/muzo', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Radio Bajka', 'http://91.232.4.24:9768', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polskie Radio RDC', 'http://stream2.nadaje.com:11140/rdc', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio KRK FM', 'http://stream4.nadaje.com:11770/test', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Rock Serwis FM', 'http://radio.rockserwis.fm/live', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Radio Wnet', 'http://audio.radiownet.pl:8000/stream', '0'])

                // POLSKA STACJA
                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Will Smith', 'http://91.121.249.22:8844', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['HOT 100 - Gorąca Setka Nowości.', 'http://188.165.23.150:80', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Muzyka Na TOPIE', 'http://188.165.22.29:9300', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Super Przeboje', 'http://188.165.21.29:2400', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Tylko Polskie Przeboje', 'http://188.165.20.29:9000', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Największe Przeboje \'80 \'90', 'http://91.121.157.133:9200', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Największe Przeboje \'60 \'70', 'http://178.32.161.114:9400', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Nastolatka', 'http://91.121.18.185:2900', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Dance 100', 'http://91.121.165.51:2200', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polskie Niezapomniane Przeboje', 'http://178.32.161.112:9100', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Przeboje We Dwoje', 'http://178.32.161.112:9050', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['DISCO POLO RADIO', 'http://178.32.161.114:9100', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polski Power Dance', 'http://91.121.77.187:4500', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['80s & Italo Disco', 'http://188.165.23.150:9700', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Era DISCO', 'http://91.121.18.185:5200', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['New Romantic', 'http://91.121.89.198:2500', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Piosenki z Filmów', 'http://91.121.77.187:6500', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Muzyka filmowa', 'http://91.121.92.167:9200', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Soul', 'http://91.121.77.187:6300', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['RnB', 'http://91.121.89.198:5800', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['HIP HOP', 'http://178.32.161.114:9300', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polski Hip Hop', 'http://188.165.20.29:6100', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['DJ TOP 50', 'http://91.121.92.167:7600', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['PARTY', 'http://188.165.23.150:8500', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Club HITS', 'http://91.121.165.51:7800', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Ibiza Hits', 'http://188.165.21.29:3300', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['HOT House', 'http://91.121.89.198:7700', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Funky House', 'http://188.165.21.29:3100', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['House & Dance', 'http://178.32.161.114:9500', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['House Progressive', 'http://188.165.21.29:3200', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['HardStyle', 'http://91.121.236.243:80', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Drum And Bass', 'http://91.121.236.242:80', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Trance Vocal', 'http://188.165.21.29:3500', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['TRAX (techno i trance)', 'http://91.121.164.186:8600', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Dancehall', 'http://91.121.92.167:4800', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Electro-House', 'http://188.165.20.29:6001', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Electro', 'http://91.121.165.51:2100', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Tylko ROCK', 'http://188.165.22.29:9400', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Ballady Rockowe', 'http://178.32.161.113:6200', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Modern ROCK', 'http://91.121.164.186:7200', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Mocne Brzmienie Rocka', 'http://91.121.89.198:5100', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Punk', 'http://87.98.236.75:3700', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Indie Rock', 'http://87.98.236.75:3800', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Gothic', 'http://91.121.165.51:2300', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polska Scena Alternatywna', 'http://87.98.236.75:3600', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Blues', 'http://188.165.20.29:5500', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Poezja Śpiewana i nie tylko ...', 'http://91.121.77.187:6600', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['CCM - Contemporary Christian', 'http://188.165.20.29:4100', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polska Muzyka Chrześcijańska', 'http://91.121.236.241:80', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['ITALIA', 'http://91.121.157.133:5000', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Muzyka Francuska', 'http://178.32.161.112:5600', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Latino', 'http://91.121.77.187:9800', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Muzyka Żydowska', 'http://91.121.89.198:2600', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Klasycznie', 'http://91.121.92.167:8900', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Klasyka Muzyki Elektronicznej', 'http://91.121.164.186:7900', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Chillout', 'http://91.121.89.153:7100', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Lounge', 'http://188.165.21.29:3400', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['JAZZ', 'http://91.121.92.167:8700', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Smooth Jazz', 'http://178.32.161.112:5700', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['EDEN (New Age & World Music)', 'http://91.121.89.153:9900', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['FOLK', 'http://91.121.89.153:8800', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Etno POP', 'http://91.121.164.186:5300', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Bollywood', 'http://91.121.92.167:4600', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Biesiada', 'http://91.121.89.153:4000', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Muzyka Ludowa', 'http://91.121.92.167:4900', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Biesiada Śląska', 'http://91.121.77.187:4300', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['W rytmie REGGAE', 'http://91.121.89.153:7000', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Polskie Reggae', 'http://91.121.77.187:4400', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Dzieciom', 'http://91.121.77.187:9600', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Boysband And Girlsband', 'http://91.121.92.167:4700', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Szanty', 'http://91.121.77.187:5400', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Fashion', 'http://188.165.21.29:3000', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Eurowizja', 'http://91.121.77.187:6400', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Country', 'http://178.32.161.114:7300', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Przeboje Na Lato', 'http://91.121.165.51:2000', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Premiery i Nowości Muzyczne', 'http://87.98.236.75:3900', '0'])

                tx.executeSql(
                            'INSERT INTO RadioStations VALUES(?, ?, ?)',
                            ['Muzyka Niemiecka', 'http://91.121.18.185:2800', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Sport', 'http://91.121.18.185:2700', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Dubstep', 'http://91.121.165.51:10000', '0'])

                tx.executeSql('INSERT INTO RadioStations VALUES(?, ?, ?)',
                              ['Fitness', 'http://91.121.165.51:11000', '0'])
            }
        })
    }

    function getAll() {
        var db = LocalStorage.openDatabaseSync("Database", "1.0",
                                               "My data.", 1000000)
        var rows
        db.transaction(function (tx) {

            var rs = tx.executeSql('SELECT * FROM RadioStations')
            rows = rs.rows
        })
        return rows
    }

    function getByTitle(title) {
        var db = LocalStorage.openDatabaseSync("Database", "1.0",
                                               "My data.", 1000000)
        var array = new Array()
        db.transaction(function (tx) {

            var rs = tx.executeSql('SELECT * FROM RadioStations')

            for (var i = 0; i < rs.rows.length; i++) {
                if (rs.rows.item(i).title.toLowerCase().search(
                            title.toLowerCase()) !== -1)
                    array.push(rs.rows.item(i))
            }
        })
        return array
    }

    function getFavorites() {
        var db = LocalStorage.openDatabaseSync("Database", "1.0",
                                               "My data.", 1000000)
        var array = new Array()
        db.transaction(function (tx) {

            var rs = tx.executeSql('SELECT * FROM RadioStations')

            for (var i = 0; i < rs.rows.length; i++) {
                if (rs.rows.item(i).favorite === 1)
                    array.push(rs.rows.item(i))
            }
        })
        return array
    }

    function addOrRemoveFromFavorites(appTitle, favoriteState) {
        var db = LocalStorage.openDatabaseSync("Database", "1.0",
                                               "My data.", 1000000)
        db.transaction(function (tx) {

            tx.executeSql('UPDATE RadioStations SET favorite=? WHERE title==?',
                          [favoriteState, appTitle])
        })
    }

    function saveTheme(number) {
        var db = LocalStorage.openDatabaseSync("Database", "1.0",
                                               "My data.", 1000000)
        db.transaction(function (tx) {
            tx.executeSql('UPDATE Theme SET number=?', [number])
        })
    }
}
