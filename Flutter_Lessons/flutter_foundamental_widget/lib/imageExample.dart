import 'package:flutter/material.dart';

class ImageExample extends StatelessWidget {
  const ImageExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imageURL =
        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARMAAAC3CAMAAAAGjUrGAAAAkFBMVEXjChf////iAAD0trjjABHjAA/jAAvjBBTiAAb0srT++fn+9/j85+jrbXH74OH63d7mNTz4z9HwmZz3yszvi47yo6XmPEL97u/51dbkEx7sdHjlIivoUVfmMTjuhon75eblJzDvkZTpW1/qY2f2w8XypqnnRUv2xMb1vL7te3/raW7nQ0noTFLkEh3wl5rpV1z5j8JlAAAES0lEQVR4nO3d6XqiMBQGYDlGgmvdLaLWunR16v3f3QRsrS0nVjQKhO/9N+3z2Hgmy8lCKJUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOBWpHBdz3MrMu2CZIKgyPxpsVxM2jL6RyXtQqUojEAwHvQazrfRfXX2rn4u0i5cKjyiZnnkcGqdfkBUtIakqsjbMxuPL61HQW7axbwhQaVB/WhEIqsNeWkX9UYk+dW/AxK53xajrhCtT4xIFJWh/f2KoNdagpAoVaK0C31d5N8ni4hSX1pdVWh8ShBqoZ9Vxdo0TlD5jxrRGYzfg11m6w/fPlZf6UsjsLT9uO7dsYC0umH+Sq6IGoqUFS9Mc2ed3W8nVgaFAj5p3TWX9ZS4YVdNh0Q/yv3HFgaFpvrxZjQ7MvFTKe8i7Jhn1gWF2vo6MvtrbuPRQtWVvmVBcQNtLSmfkn941HecV6uCIkjXl9S3JyYfFNw5C5uCQroRp3d6klqhgdO2Z/ZDujnfIFGGSs26Z0tGS01NSJIOJTRZWdJ6hK8JSTPxF6TN2I4VFerwITlnGPHavvkC3p5u3vd4VjOwoj+RxGcmZUt6hnOoEZTzYGRNxM1ltRH/+JYzN7EiQms/j0HRpCZm5i700slhC5QeG5KWma9C5TzOlqnLxuTJTI4ertvlL93n537Phv5zw5g08raA7S3ZatI2tOQcre/mbVCnFy4kPVPfYrfmnXyKkCZNvrY11QV87gP4v6udyPA2Gd90RsYK/BmTux8fWCGad9eZDQqfnHRNx8QZ7D9RBWTabTlOdudF1OBiMjW2qbffQ9vt/rhEw0H0J7eZrSaSuJA0zJV3H5O6J1RANuvR73qTOXx3Ur1CTNRQNqnuUyFDWfJV0AcXE4Mbegf7z4fHnmLjUIbw2Ym57qTE78lneheV3cGomSuxZMe1lyyHpETcOT5TjT08XNt8iH/+KNvzH3bYMZLYq4CI1x738c4w0/NkyS6xXT7sqMxdzjR7AVnfaBdTrtAX5g4qIEFffybO2PTySipDrtQXZfaS5o/HDjvVs75oXXk3HRPpr44ExMnBaQzUkzj0J3EYdxjIT+KQx8ZhvhOHeXEc1k/i+HU2g3tUOVxnw3osg5hxwdzOaC7X7bG/w8A+YJxuv9jUGdc87hfjXAED508YOKcUh/NscTj3yNBcTlDk87H6c9QmqnxOz1Hrztub6RqzviStgecyGHh+h4HnvOLwPCDD3HOjW1ueGzX5fHHuEnk97XPoncI+h477Cji414Jh4P6TPE73jrvknpxl2B3ZF5Lz71OS9t6npPoUL9m9W2T/vVuJ72drft/P9mDr/Wwl3OPHwn2PDNwLysH9sYwk9wxPinHPcOn0+6ifChOREO4tZx27375XxPvtI/v3IByMROF7EIaFfQ/CzuH7MjZTUfj3ZXyL3qvi4r0qAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC2+A8wJj1Fqfr12AAAAABJRU5ErkJggg==";

    String _logoURL =
        "data:image/jpeg;base64,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";

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red.shade300,
                    height: 200,
                    child: Image.asset("assets/images/lion.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red.shade300,
                    child: Image.network(_imageURL, fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.red.shade300,
                      child: CircleAvatar(
                        /*   child: Text(
                      "E",
                      style: Theme.of(context).textTheme.headline1,
                    ),*/
                        radius: 40,
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.red,
                        backgroundImage: NetworkImage(_logoURL),
                        //backgroundImage: AssetImage(_imageURL),
                      )),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: FadeInImage.assetNetwork(
                //fit: BoxFit.cover,
                placeholder: "assets/images/loading.gif",
                image: _imageURL),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Placeholder(
                  color: Colors.blue,
                )),
          )
        ],
      ),
    );
  }
}
