<template>
  <div class="container">
    <div style="align-self: center; font-size: 18px; margin-bottom: 16px">
      ZKOPRU Testnet Status
    </div>
    <div>
      Latest Block: #{{ +latestBlock.canonicalNum || 0}}
    </div>
    <div style="margin-left: 8px">
      - {{ latestBlock.body.txs.length }} transaction{{ latestBlock.body.txs.length === 1 ? '' : 's' }}
      <br />
      - {{ latestBlock.body.massDeposits.length }} mass deposit{{ latestBlock.body.txs.length === 1 ? '' : 's' }}
    </div>
    <div>
      Proposed: {{ dayjs().to(dayjs(1000 * +latestBlock.timestamp)) }}
    </div>
    <div>
      Created At L1 Block: <a :href="`https://goerli.etherscan.io/tx/${latestBlock.proposalTx}`">#{{ +latestBlock.proposedAt || 0}}</a>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import Component from 'vue-class-component'
import dayjs from 'dayjs'
import relativeTime from 'dayjs/plugin/relativeTime'

dayjs.extend(relativeTime)

@Component({
  name: 'Home',
  components: {},
  metaInfo: {
    title: 'ZKOPRU Status',
  },
})
export default class Home extends Vue {
  dayjs = dayjs
  latestBlock = {
    body: {
      txs: [],
      massDeposits: []
    }
  }
  nodeUrl = 'https://node.zkopru.network/'
  async mounted() {
    await this.loadLatestBlock()
  }

  async loadLatestBlock() {
    const res = await fetch(this.nodeUrl, {
      method: 'post',
      headers: {
        accept: 'application/json',
        'content-type': 'application/json',
      },
      body: JSON.stringify({
        id: Math.floor(Math.random() * 100000000),
        jsonrpc: '2.0',
        method: 'l2_getBlockByNumber',
        params: ['latest', false],
      })
    })
    const data = await res.json()
    this.latestBlock = data.result
  }
}
</script>

<style scoped>
.container {
  margin: auto;
  max-width: 400px;
  display: flex;
  flex-direction: column;
}
</style>
