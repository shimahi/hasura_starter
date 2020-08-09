const path = require('path')
const { argv } = require('yargs')
const HTMLPlugin = require('html-webpack-plugin')
const WorkerPlugin = require('worker-plugin')
const Dotenv = require('dotenv-webpack')
const { EnvironmentPlugin } = require('webpack')

module.exports = {
  entry: './src/index.tsx',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js',
  },
  resolve: {
    extensions: ['.js', '.ts', '.tsx', '.json', '.mjs', '.wasm'],
    modules: [path.resolve(__dirname, 'src'), 'node_modules'],
    alias: {
      src: path.resolve(__dirname, 'src'),
    },
  },
  module: {
    rules: [
      {
        test: /\.ts(x?)$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
          },
          {
            loader: 'ts-loader',
            options: {
              transpileOnly: true,
            },
          },
        ],
      },
      {
        // cssファイルは自前で書かない(emotionを使う)が、animate.css等のcssライブラリを使うためにローダーを入れる
        test: /.css$/,
        include: /node_modules/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              modules: false,
              url: true,
              importLoaders: 1,
            },
          },
        ],
      },
      {
        test: /\.(gif|png|jpg|eot|wof|woff|ttf|svg)$/,
        use: [
          {
            loader: 'url-loader',
            options: {
              limit: 100 * 1024,
              name: './img/[name].[ext]',
            },
          },
        ],
      },
    ],
  },
  plugins: [
    new HTMLPlugin({
      template: path.join(__dirname, 'src/index.html'),
    }),

    new WorkerPlugin(),
    argv.mode === 'development'
      ? new Dotenv({ path: path.join(__dirname, '.env') })
      : new EnvironmentPlugin(Object.keys(process.env)),
  ],
}
