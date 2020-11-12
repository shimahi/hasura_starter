import 'ress'
import { render } from 'react-dom'
import AppProvider from 'store'

const App = () => {
  return <h1>Hello React!</h1>
}

render(
  <AppProvider>
    <App />
  </AppProvider>,
  document.getElementById('root'),
)
